import os
from Bio import SeqIO

def fasta_to_paml_in_pwd():
    # Get the current working directory
    cwd = os.getcwd()
    
    for fasta_file in os.listdir(cwd):
        if fasta_file.endswith(".fna"):
            input_path = os.path.join(cwd, fasta_file)
            output_path = os.path.join(cwd, os.path.splitext(fasta_file)[0] + ".phy")
            
            # Read sequences from FASTA file
            sequences = list(SeqIO.parse(input_path, "fasta"))
            num_sequences = len(sequences)
            alignment_length = len(sequences[0].seq)
            
            # Check alignment consistency
            if not all(len(record.seq) == alignment_length for record in sequences):
                print(f"Error: Alignment inconsistency in {fasta_file}. Skipping.")
                continue
            
            # Shorten sequence IDs if needed
            for record in sequences:
                record.id = record.id[:10]
            
            # Write in PAML format
            with open(output_path, "w") as out_f:
                out_f.write(f" {num_sequences} {alignment_length}\n")
                for record in sequences:
                    out_f.write(f"{record.id.ljust(10)} {record.seq}\n")
            
            print(f"Converted {fasta_file} to {output_path}")

# Run the script
if __name__ == "__main__":
    fasta_to_paml_in_pwd()
