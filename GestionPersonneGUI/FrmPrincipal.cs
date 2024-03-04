using System;
using System.Windows.Forms;

namespace GestionPersonneGUI
{
    public partial class FrmPrincipal : Form
    {
        public FrmPrincipal()
        {
            InitializeComponent();
        }

        public void ActivateItems(bool status)
        {
            smConnection.Enabled = !status;
            tblConnection.Enabled = !status;
            smDisconnection.Enabled = status;
            smPersons.Enabled = status;
            smListPersons.Enabled = status;
            tblPreview.Enabled = status;
        }
        private void smCloseAll_Click(object sender, EventArgs e)
        {
            foreach (Form formEnfant in MdiChildren)
            {
                formEnfant.Close();
            }
        }

        private void smToolbar_Click(object sender, EventArgs e)
        {
            toolStrip.Visible = smToolbar.Checked;
        }

        private void smStatusBar_Click(object sender, EventArgs e)
        {
            stStatus.Visible = smStatusBar.Checked;
        }

        private void smConnection_Click(object sender, EventArgs e)
        {
            FrmConnexion frm = new FrmConnexion();
            // Affection de notre Mutateur de frmPrincipal a
            // partir de frmConnexion
            frm.Main_form = this;
            frm.MdiParent = this;
            frm.Icon = this.Icon;
            frm.Show();
        }

        private void tblConnection_Click(object sender, EventArgs e)
        {
            FrmConnexion frm = new FrmConnexion();
            frm.MdiParent = this;
            frm.Icon = this.Icon;
            frm.Show();
        }

        private void frmPrincipal_Load(object sender, EventArgs e)
        {
            // Desativation des tous les champs a desactiver
            ActivateItems(false);
        }

        private void smExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void smDisconnection_Click(object sender, EventArgs e)
        {
            try
            {
                ManageSingleConnexion.ImplementeConnexion.Instance.Conn.Close();
            }
            catch (NullReferenceException) { }
            catch (InvalidOperationException) { }

            // Desactivation des champs
            ActivateItems(false);
        }

        private void smPersons_Click(object sender, EventArgs e)
        {
            FrmEtudiant frm = new FrmEtudiant();
            frm.MdiParent = this;
            frm.Icon = this.Icon;
            frm.Show();
        }

        private void smListPersons_Click(object sender, EventArgs e)
        {
            FrmReport frm = new FrmReport();
            frm.MdiParent = this;
            frm.Icon = this.Icon;
            frm.Show();
        }

        private void tblPreview_Click(object sender, EventArgs e)
        {
            FrmReport frm = new FrmReport();
            frm.MdiParent = this;
            frm.Icon = this.Icon;
            frm.Show();
        }
    }
}
