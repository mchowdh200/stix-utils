from dataclasses import dataclass
from os.path import basename
from pathlib import Path


@dataclass
class Config:
    n_shards: int = 8
    bed_dir: Path = Path("/scratch/Shares/layer/stix/indices/1kg_high_coverage/bed")
    output_dir: Path = Path("/scratch/Shares/layer/stix/indices/1kg_high_coverage/")
    data_listing: Path = Path("1000G_2504_high_coverage.sequence.txt")

    def samples(self):
        """
        Parse function to get sample names from the data listing
        """
        return [
            basename(line.split()[0]).split(".")[0]
            for line in open(self.data_listing, "r").readlines()
            if not line.startswith("#")
        ]

    def partitions(self):
        samples = self.samples()
        shard_size = len(samples) // self.n_shards
        return [samples[i : i + shard_size] for i in range(0, len(samples), shard_size)]
