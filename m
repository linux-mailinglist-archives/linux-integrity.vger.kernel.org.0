Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB183257D2
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 21:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhBYUha (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 15:37:30 -0500
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:56288
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234392AbhBYUfK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 15:35:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnjIBDzgAgmC7Iz/4CTtdCiSc/OpEpTH5PmipSgrJuacOIAlVHi616pMQQChj5t/bbSTdO24wAhhKGNAlyBHH0FAayJhn1y4ljiwLSOXM7V4ALBsk3romV0ESOnFdjwKRByIbKpzR0qbNgkUvpldwD2JYmdkjtaNSFOdx/uvseqFo2hoMhLRSowOqVOtmeFWsd+IuhiNTpoPU5ooNamFnCOV6kqX3wuuC7tLvJIXSQ7OEqRs2KXE93EjA9SbI+YWH8/zZCEZZg5nveMxW7+C0tSUpXjCzjw9grINUUdiGgTfTCvOHmMwnDDhEolc8onfj/SOhVzxJiBjc5PsQOqN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJopkiPgeOLXUirdW4cZujCT+zLaZPKKseTrrcsa2YM=;
 b=DO+Eq4b9aV69QYavh++TflXWReN4hGVwjh3IJICHZVOi9MF9I4Xap5X/UCGByjOxjt+i7+tJYxjAhvq8p7ZBQcT40Y046wM+Tj003iQ28tiAEeJens+/xEqoSE850FFJgEurLh0uR1cxGzShGEreuQRuE5m1ga5QX9uVtR2aic9TSYjWG4VGGdp0vQ/ilbZ+71ey6VwswW9WMmbvJW46u5idfyXMnW4XYphbPPNq2Cz0YXNhpse64gnd1X4D+ymEjwb9qwJdHOySUdwdBHs5kGgET+8C4ONZLo7DFOdVbPJABmmFClXEBn0XzKdibHK1qR5Rdoaj4yCq4T+hV+qKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJopkiPgeOLXUirdW4cZujCT+zLaZPKKseTrrcsa2YM=;
 b=cmmwKEBTSBvyK12XIbnGiLc5dBkzG6zfiB8TUJ376LFPAV3Axp0zDhVudVoVCIId3M9yYWl10rgmF3Hw0Odsgj1XORVqXJB2xi1ZuvtB/JZYChAfR3pxJ3VJmjm3eXEC+bp5X4YYv6xABMuR+PoUnDh3w8TJpTVtaVWQw+mJhEjfvVkr1xTMP5pHJ/4b89vQOAYKFv+kUihZSrwxqYRWnrohpsxNYnjvV0SbFilsIIvpVAVmyFqhYEOCcz2d30cy72VM9+v2j+hDKdw+wuN1feW0aXBKbKLRz1nSAxggEBXXURkovuSjGoYbGvmNv1ZOn7tBSDQyFZ+0RsrtarArEg==
Authentication-Results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM4P191MB0083.EURP191.PROD.OUTLOOK.COM (2603:10a6:200:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 20:32:47 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::b002:8668:5cfa:a46b]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::b002:8668:5cfa:a46b%8]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 20:32:47 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, stefanb@linux.ibm.com, kgold@linux.ibm.com,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 1/3] tpm: Add support for reading a TPM NV Index
Date:   Thu, 25 Feb 2021 21:32:27 +0100
Message-Id: <20210225203229.363302-2-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225203229.363302-1-patrick@puiterwijk.org>
References: <20210225203229.363302-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:ec87:3741:6e9a:b11e]
X-ClientProxiedBy: AM0PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:208:14::31) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.mgmt.home.puiterwijk.org (2a10:3781:662:0:ec87:3741:6e9a:b11e) by AM0PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:208:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 20:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dda4fd1-88d8-406d-09f6-08d8d9cc8337
X-MS-TrafficTypeDiagnostic: AM4P191MB0083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4P191MB00837D8257249388DF608673C89E9@AM4P191MB0083.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K24YtaAJ54ozPXd2QLmI+GTVCzUlqxEp/RaUuhuGtbdqHGDiM/jhJANLtlITn1gQPfvJZlYfdJMmiyVnttYMhMFkZpLnVYmbDR9cz7xT8hY6Tr4gbW/+WtFyOOiXeYaihw6Wt2m+6sr3XfA3u+KeeHkyqr0GfYh3ChuSULK1xGEqoEDG+/0l7vtvs4QiGdLuCbNsxIHJZOrdG/Dn0mzCUmVLXEv/MTR208+p+KXHx8XBkdj3J6GY5Ule6v8XD0l1+IXLUQV+4kYz09qtZGzRiAHEHClykStD6VNFegNVLBpHm5ON7GWhW/36IQnBQzVKAMaZJvNWHyJZWWhuMs2PsvRHNKdohrqrAMT/R5anRxhDtbfJ7RyrXv3dyNzq6X9aYispz02psd+bt4JzSYg8ULXcIclQ9TeqTvd7oM09Q8AMkf9WUaK/TiACZz0LdFYNziYR8R0AG4SFmaFUfSzoYBlJG1ogpACxXB0TEik3TsGndlAnBKDS0GwZmacVxbdS0q16F0jaUr7Nf4FDdDhhGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(136003)(346002)(366004)(396003)(2616005)(316002)(186003)(107886003)(6486002)(30864003)(5660300002)(4326008)(66476007)(1076003)(478600001)(66946007)(6666004)(2906002)(36756003)(7696005)(52116002)(66556008)(83380400001)(8676002)(8936002)(16526019)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?85G8BAC5MDN848wnhINwIYw9Eiko7DU/4nQjDs3k25KtjRV4+XdQXyv0jNjb?=
 =?us-ascii?Q?bEpkGxNR81HKSOPwd+NzP6TkfCgJk9G51ZXls23ts56QNgqPg1WrY27uuEFK?=
 =?us-ascii?Q?ESdKKDqiRfgWkdV2DKFszDoPs18Rs+xyNv3TPBbkpOKs5B/EigHeohwylXt4?=
 =?us-ascii?Q?bnGph9gTVg8dx9LcXpi5naSeW2hRs2Fc/9Nlmu09m91CIaZC5VOUBiBDb/ml?=
 =?us-ascii?Q?Xy+J3k4IK2PXgSR+i08CcHqZrQShwEdFF6S4uYxFzMG8dppSiE0RUhgRkpsM?=
 =?us-ascii?Q?h0SvLDBv6OngbI5H9VnXCjC3lJC6bLpSKpdDMG7Fb7HvcLAftKNyJq6J0Thx?=
 =?us-ascii?Q?lwaYKdxMYqcwGcGS+J6BxiDC5kY6FjU9EMGrf96nbiW5jYbkcBa2UYjN+y5s?=
 =?us-ascii?Q?nVYvva+DJWy73pS5QJKWT5nSnyawCy1TKm56JL+0LUB8dnEyxEUJK03yivRS?=
 =?us-ascii?Q?L7q2QhO9NgCUIRNcs5waXE+aRsfLPUA7JiUTlKfC67tP/cSc//pAl1v+98vv?=
 =?us-ascii?Q?mcBfz3pQWZmHdTiBYJOqeXJYXrJ2CeOjBPwnxBt8cd50XeB9bR1UalWC25dW?=
 =?us-ascii?Q?NEdVgWwTs7x3PMwPmsKco45uKf/NdTuuF9WlyzglypdSejboFOrk7j57va75?=
 =?us-ascii?Q?zquNMLEKj3QIlJyC6UiPv7C1PUof6Z3YtfYr6yWfWDvk5Ouf/VjOeu9Z2NKc?=
 =?us-ascii?Q?dPK0Fplc8sucpaYc+TYVGnBCp7NEweKglc8efJB/YZLsqznegXgjOt0I39Z4?=
 =?us-ascii?Q?9c5ddrtwvDlmq6V0EHcZP1PMXS/RSd/nX1dX4XJkkbwH4oKGfBxhil64vP/e?=
 =?us-ascii?Q?4MN70WGoPQeSTGcBnsBh+cB+hK54NVFYzHJYeqvUWQqQPI3iWz74Oj58yGDg?=
 =?us-ascii?Q?Eyng7XoFZsDNSKePiVYFRRXcZyybXW/j3bCyDi7HVSauaqwUEUC+GOxFHnXc?=
 =?us-ascii?Q?TFE3pNKsbvMLdQiSIVLwjRlAUPs+wWZJv47x/4brAk4+J9I0pyasSIoa4M2h?=
 =?us-ascii?Q?2VN5sGBcKJkeMFthOSsCHrZKBSRAaEiAM6Kru4Ed0u9cnlMLfZMbh+wnI6ZR?=
 =?us-ascii?Q?biHkD1aQieYhej3YIxZPTbtHeFssp1p9rgWeJCQ/vDpv6d1R6wNWnGn1Tz7f?=
 =?us-ascii?Q?OUDUvHKagmVZwKGzt1s/wJuU+UywwUvsBJ8uMqxY0OGAlwJ1jplaYLu2fm9D?=
 =?us-ascii?Q?6Al4AlN41TKiahfs4+Iho+V4W9dobBjjS/qW0EFLCagungoLntgck8ajJb99?=
 =?us-ascii?Q?GJfzUlm+TTSwiZouARYjAcY2vNqOW3rrE2mGfaCgTeAa5fqx/Cof6g2i+tMg?=
 =?us-ascii?Q?svh5oyTvH2NI4I1/7vtwMSvVqjwEMcIVRNwsNEC8NT+jEbIBHxG93sL1CML6?=
 =?us-ascii?Q?lILC6E3IvmkJ+kou8pbtGryNCmsw?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dda4fd1-88d8-406d-09f6-08d8d9cc8337
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:32:47.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFsHGQliXeNZXzmiTiCW/RI7Xi/prsfdz6XGJodBx/vICo26j2Z0oqUQJ3wPe7Ms4XeJMq6nxpQFpNYWKBkkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P191MB0083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add support to read contents from a TPM2 Non-Volatile Index location,
allowing the kernel to retrieve contents and attributes of NV indexes.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 drivers/char/tpm/tpm-interface.c |  30 ++++++
 drivers/char/tpm/tpm.h           |   5 +
 drivers/char/tpm/tpm2-cmd.c      | 163 +++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  65 ++++++++++++
 4 files changed, 263 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce818705..9d81c11181d4 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -342,6 +342,36 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
+/**
+ * tpm_nv_read - Read an NV Index from the TPM
+ * @chip:	A &struct tpm_chip instance, %NULL for the default chip
+ * @nv_idx:	The NV Index to be retrieved
+ * @attr_out:	A place to store returned attributes if a TPM 2 was used
+ * @out:	A pointer where to store the return buffer
+ *
+ * Return: number of bytes read or a negative error value
+ */
+int tpm_nv_read(struct tpm_chip *chip, u32 nv_idx, u32 *attr_out, void **out)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		rc = tpm2_nv_read(chip, nv_idx, attr_out, out);
+		goto out;
+	}
+
+	rc = -ENODEV;
+
+out:
+	tpm_put_ops(chip);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_nv_read);
+
 /**
  * tpm_send - send a TPM command
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..d4dfc5148adb 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -56,9 +56,12 @@ enum tpm_addr {
 #define TPM_ERR_DEACTIVATED     0x6
 #define TPM_ERR_DISABLED        0x7
 #define TPM_ERR_INVALID_POSTINIT 38
+#define TPM_ERR_INVALID_HANDLE_1 0x18b
 
 #define TPM_TAG_RQU_COMMAND 193
 
+#define TPM2_HR_NV_INDEX 0x1000000
+
 /* TPM2 specific constants. */
 #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
 
@@ -224,6 +227,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
+int tpm2_nv_read(struct tpm_chip *chip, u32 nvindex, u32 *attr_out, void **dest);
+int tpm2_nv_readpublic(struct tpm_chip *chip, u32 nvindex, struct tpm2_nv_public *info);
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index eff1f12d981a..ba1026123464 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -269,6 +269,169 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
+struct tpm2_buffer_out {
+	__be16	size;
+	u8	data[];
+} __packed;
+
+struct tpm2_nv_public_out {
+	__be32	nvIndex;
+	__be16	nameAlg;
+	__be32	attributes;
+	__be16	authPolicySize;
+	u8	data[];
+} __packed;
+
+int tpm2_nv_readpublic(struct tpm_chip *chip, u32 nvindex, struct tpm2_nv_public *info)
+{
+	struct tpm_buf buf;
+	int rc;
+	u16 recd;
+	u32 resp_header_length;
+	struct tpm2_buffer_out *out;
+	struct tpm2_nv_public_out *publicout;
+	u32 nvhandle;
+	u16 auth_policy_size;
+
+	if ((nvindex & ~TPM2_HR_NV_INDEX) > 0x00FFFFFF)
+		return -EINVAL;
+
+	/* HR_NV_INDEX = TPM_HT_NV_INDEX << HR_SHIFT */
+	nvhandle = TPM2_HR_NV_INDEX | nvindex;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_NV_READPUBLIC);
+	if (rc)
+		return rc;
+	tpm_buf_append_u32(&buf, nvhandle);
+	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
+	if (rc) {
+		if (rc != TPM_ERR_DISABLED && rc != TPM_ERR_DEACTIVATED
+		    && rc != TPM2_RC_TESTING && rc != TPM_ERR_INVALID_HANDLE_1)
+			dev_err(&chip->dev, "A TPM error (%d) occurred attempting to read an NV Index public\n", rc);
+		if (rc == TPM_ERR_INVALID_HANDLE_1)
+			rc = -ENOENT;
+		else if (rc > 0)
+			rc = -EIO;
+		goto out;
+	}
+	resp_header_length = tpm_buf_response_header_length(&buf, 0);
+	out = (struct tpm2_buffer_out *)&buf.data[resp_header_length];
+	publicout = (struct tpm2_nv_public_out *)&out->data;
+	recd = be16_to_cpu(out->size);
+
+	info->nv_index = be32_to_cpu(publicout->nvIndex);
+	info->name_alg = be16_to_cpu(publicout->nameAlg);
+	info->attributes = be32_to_cpu(publicout->attributes);
+
+	/* Determine the size of the authPolicy, so we can skip over that to grab the data size */
+	auth_policy_size = be16_to_cpu(publicout->authPolicySize);
+
+	info->data_size = be16_to_cpu((publicout->data[auth_policy_size]) | (publicout->data[auth_policy_size+1] << 8));
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
+int tpm2_nv_read(struct tpm_chip *chip, u32 nvindex, u32 *attr_out, void **dest)
+{
+	struct tpm_buf buf;
+	int rc;
+	struct tpm2_buffer_out *out;
+	u16 recd;
+	u16 copied;
+	u32 nvhandle;
+	u32 resp_header_length;
+	struct tpm2_null_auth_area auth_area;
+	u16 size;
+	struct tpm2_nv_public public;
+
+	copied = 0;
+
+	if ((nvindex & ~TPM2_HR_NV_INDEX) > 0x00FFFFFF)
+		return -EINVAL;
+
+	/* HR_NV_INDEX = TPM_HT_NV_INDEX << HR_SHIFT */
+	nvhandle = TPM2_HR_NV_INDEX | nvindex;
+
+	/* Determine the size of the NV Index contents */
+	rc = tpm2_nv_readpublic(chip, nvindex, &public);
+	if (rc < 0)
+		return rc;
+	if (attr_out != NULL)
+		*attr_out = public.attributes;
+	size = public.data_size;
+	*dest = kzalloc(size, GFP_KERNEL);
+	if (!*dest) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Retrieve the actual NV Index contents */
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_NV_READ);
+	if (rc)
+		goto out_free;
+
+	while (copied < size) {
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_NV_READ);
+
+		tpm_buf_append_u32(&buf, TPM2_RH_OWNER);
+		tpm_buf_append_u32(&buf, nvhandle);
+
+		auth_area.handle = cpu_to_be32(TPM2_RS_PW);
+		auth_area.nonce_size = 0;
+		auth_area.attributes = 0;
+		auth_area.auth_size = 0;
+
+		tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
+		tpm_buf_append(&buf, (const unsigned char *)&auth_area,
+			       sizeof(auth_area));
+
+		/* Size to request: at most 512 bytes at a time */
+		tpm_buf_append_u16(&buf, min_t(u16, 512, size-copied));
+		/* Offset: start at where we ended up */
+		tpm_buf_append_u16(&buf, copied);
+
+		rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read NV index");
+		if (rc) {
+			if (rc > 0)
+				rc = -EIO;
+			goto out_free;
+		}
+		resp_header_length = tpm_buf_response_header_length(&buf, 0);
+		out = (struct tpm2_buffer_out *)&buf.data[resp_header_length];
+		recd = be16_to_cpu(out->size);
+
+		if (recd == 0) {
+			rc = -EIO;
+			goto out_free;
+		}
+		if (recd > size-copied) {
+			rc = -EIO;
+			goto out_free;
+		}
+
+		memcpy(*dest + copied, out->data, recd);
+		copied += recd;
+	};
+
+out_free:
+	if ((rc < 0) || (copied != size)) {
+		kvfree(*dest);
+		*dest = NULL;
+	}
+
+out:
+	tpm_buf_destroy(&buf);
+
+	if (rc < 0)
+		return rc;
+	else if (copied != size)
+		return -EIO;
+	else
+		return size;
+}
+
 struct tpm2_get_random_out {
 	__be16 size;
 	u8 buffer[TPM_MAX_RNG_DATA];
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8f4ff39f51e7..b812236b9955 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -53,6 +53,40 @@ struct tpm_bank_info {
 	u16 crypto_id;
 };
 
+enum tpm_nv_public_attrs {
+	TPM2_ATTR_NV_PPWRITE = 0x00000001,
+	TPM2_ATTR_NV_OWNERWRITE = 0x00000002,
+	TPM2_ATTR_NV_AUTHWRITE = 0x00000004,
+	TPM2_ATTR_NV_POLICYWRITE = 0x00000008,
+	/* Bits 4-7 TPM_NT */
+	/* Bits 8-9 reserved */
+	TPM2_ATTR_NV_POLICY_DELETE = 0x00000400,
+	TPM2_ATTR_NV_WRITELOCKED = 0x00000800,
+	TPM2_ATTR_NV_WRITEALL = 0x00001000,
+	TPM2_ATTR_NV_WRITE_DEFINE = 0x00002000,
+	TPM2_ATTR_NV_WRITE_STCLEAR = 0x00004000,
+	TPM2_ATTR_NV_GLOBALLOCK = 0x00008000,
+	TPM2_ATTR_NV_PPREAD = 0x00010000,
+	TPM2_ATTR_NV_OWNERREAD = 0x00020000,
+	TPM2_ATTR_NV_AUTHREAD = 0x00040000,
+	TPM2_ATTR_NV_POLICYREAD = 0x00080000,
+	/* Bits 20-24 reserved */
+	TPM2_ATTR_NV_NO_DA = 0x02000000,
+	TPM2_ATTR_NV_ORDERLY = 0x04000000,
+	TPM2_ATTR_NV_CLEAR_STCLEAR = 0x08000000,
+	TPM2_ATTR_NV_READLOCKED = 0x10000000,
+	TPM2_ATTR_NV_WRITTEN = 0x20000000,
+	TPM2_ATTR_NV_PLATFORMCREATE = 0x40000000,
+	TPM2_ATTR_NV_READ_STCLEAR = 0x80000000,
+};
+
+struct tpm2_nv_public {
+	u32 nv_index;
+	u16 name_alg;
+	u32 attributes;
+	u16 data_size;
+};
+
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -189,6 +223,10 @@ enum tpm2_structures {
 	TPM2_ST_SESSIONS	= 0x8002,
 };
 
+enum tpm2_root_handles {
+	TPM2_RH_OWNER		= 0x40000001,
+};
+
 /* Indicates from what layer of the software stack the error comes from */
 #define TSS2_RC_LAYER_SHIFT	 16
 #define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
@@ -223,6 +261,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_NV_READPUBLIC		= 0x0169,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
@@ -389,6 +428,21 @@ static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *) &value2, 4);
 }
 
+static inline u32 tpm_buf_response_header_length(struct tpm_buf *buf, bool has_shielded_locations)
+{
+	u32 header_length = TPM_HEADER_SIZE;
+
+	/* Possibly a handle for a Shielded Location */
+	if (has_shielded_locations)
+		header_length += 4;
+
+	/* Possibly the 32-bit parameter area size */
+	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
+		header_length += 4;
+
+	return header_length;
+}
+
 static inline u32 tpm2_rc_value(u32 rc)
 {
 	return (rc & BIT(7)) ? rc & 0xff : rc;
@@ -401,6 +455,7 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
+extern int tpm_nv_read(struct tpm_chip *chip, u32 nv_idx, u32 *attrs_out, void **out);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
@@ -423,6 +478,16 @@ static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return -ENODEV;
 }
 
+static inline int tpm2_nv_readpublic(struct tpm_chip *chip, u32 nvindex, struct tpm2_nv_public *info)
+{
+	return -ENODEV;
+}
+
+static inline int tpm_nv_read(struct tpm_chip *chip, u32 nv_idx, u8 *out, size_t max)
+{
+	return -ENODEV;
+}
+
 static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 {
 	return -ENODEV;
-- 
2.29.2

