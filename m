Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4BF4E744E
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Mar 2022 14:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352892AbiCYNis (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Mar 2022 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356546AbiCYNis (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Mar 2022 09:38:48 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED73D76C1
        for <linux-integrity@vger.kernel.org>; Fri, 25 Mar 2022 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1648215434; x=1679751434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YW/zS5OL0dWRIXkCM3j1ryKtKS2Vy6gzAQrOEWA/A78=;
  b=hRZhh+EHeRjbWnhl6h3ytbzSRzFP3EGdqsAjqdh583QmlmJ5Vk6T9lVA
   fxyL45cHeiQxF5rKcxLCWc6j8exZQxd8ob8NunJHANzHaxogMasRwm2tE
   7a2i4qB5nowj26PLpV9c3b5qCyFrxM4UmLILnxyRZc/JEyRmI+cte+HKG
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="114319714"
X-IronPort-AV: E=Sophos;i="5.90,209,1643670000"; 
   d="scan'208";a="114319714"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 14:37:12 +0100
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 25 Mar 2022 14:37:11 +0100 (CET)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 14:37:10 +0100
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
CC:     Johannes Holland <johannes.holland@infineon.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] tpm: Fix regression in tpm_tis_synquacer.c
Date:   Fri, 25 Mar 2022 14:36:27 +0100
Message-ID: <20220325133627.1619-1-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove unused variables and type mismatch (integer from pointer without
a cast).

Reported-by: kernel test robot <lkp@intel.com>
Fixes: a536629ef32d ("tpm: Remove read16/read32/write32 calls from tpm_tis_=
phy_ops")
Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---=0D
Like v1, this applies to Jarkko's master branch. If you need me to=0D
rebase to another branch, please let me know.=0D
=0D
Sorry for the inconvenience!=0D
=0D
sparse warnings: (new ones prefixed by >>)=0D
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect ty=
pe in argument 1 (different base types) @@     expected unsigned char [user=
type] value @@     got unsigned char const [usertype] * @@=0D
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     expected unsigne=
d char [usertype] value=0D
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     got unsigned cha=
r const [usertype] *=0D
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse: sparse: incorrect ty=
pe in argument 1 (different base types) @@     expected unsigned char [user=
type] value @@     got unsigned char const [usertype] * @@=0D
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     expected unsigne=
d char [usertype] value=0D
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     got unsigned cha=
r const [usertype] *=0D
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse: sparse: incorrect ty=
pe in argument 1 (different base types) @@     expected unsigned char [user=
type] value @@     got unsigned char const [usertype] * @@=0D
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     expected unsigne=
d char [usertype] value=0D
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     got unsigned cha=
r const [usertype] *=0D
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse: sparse: incorrect ty=
pe in argument 1 (different base types) @@     expected unsigned char [user=
type] value @@     got unsigned char const [usertype] * @@=0D
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     expected unsigne=
d char [usertype] value=0D
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     got unsigned cha=
r const [usertype] *=0D
   drivers/char/tpm/tpm_tis_synquacer.c:89:33: sparse: sparse: non size-pre=
serving pointer to integer cast=0D
   drivers/char/tpm/tpm_tis_synquacer.c:90:33: sparse: sparse: non size-pre=
serving pointer to integer cast=0D
   drivers/char/tpm/tpm_tis_synquacer.c:91:33: sparse: sparse: non size-pre=
serving pointer to integer cast=0D
   drivers/char/tpm/tpm_tis_synquacer.c:92:33: sparse: sparse: non size-pre=
serving pointer to integer cast=0D

 drivers/char/tpm/tpm_tis_synquacer.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_ti=
s_synquacer.c
index 2751be8e6065..679196c61401 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -39,11 +39,6 @@ static int tpm_tis_synquacer_read_bytes(struct tpm_tis_d=
ata *data, u32 addr,
 					enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-	__le16 result_le16;
-	__le32 result_le32;
-	u16 result16;
-	u32 result32;
-
 	switch (io_mode) {
 	case TPM_TIS_PHYS_8:
 		while (len--)
@@ -69,11 +64,6 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_=
data *data, u32 addr,
 					 enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-	__le16 result_le16;
-	__le32 result_le32;
-	u16 result16;
-	u32 result32;
-
 	switch (io_mode) {
 	case TPM_TIS_PHYS_8:
 		while (len--)
@@ -86,10 +76,10 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis=
_data *data, u32 addr,
 		 * Due to the limitation of SPI controller on SynQuacer,
 		 * 16/32 bits access must be done in byte-wise and descending order.
 		 */
-		iowrite8(&value[3], phy->iobase + addr + 3);
-		iowrite8(&value[2], phy->iobase + addr + 2);
-		iowrite8(&value[1], phy->iobase + addr + 1);
-		iowrite8(&value[0], phy->iobase + addr);
+		iowrite8(value[3], phy->iobase + addr + 3);
+		iowrite8(value[2], phy->iobase + addr + 2);
+		iowrite8(value[1], phy->iobase + addr + 1);
+		iowrite8(value[0], phy->iobase + addr);
 		break;
 	}
=20
--=20
2.31.1.windows.1

