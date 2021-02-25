Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824E03257CF
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 21:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhBYUgK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 15:36:10 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:59131
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231974AbhBYUeO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 15:34:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BasIxZObeQR27t8PHVEfMLSRyMtO6pYn3y/wSGBABmkiL/Cr3F+HIgFp849SVE30vrPdmPZvbO4l699s7yiPgBU4Gkp8pTnQ6qm5bm3S2TU6q/O0NamnLpfnAKrrSRnHBXCwQc7fKokV360c+Us1seitYJikJ6qA/6DlI/CWC8sFY61LIxtvTklrCxPwSKvBEH4Xg8YKYKxEOE0iLHSVsgwQEgqetbMajnvX0zTzjCYY2Z98zu1Ais7KVzzKs3EFQ++/Pocvhy6J6p7oVJCsij157DA53TQuYrIg55IUTKeOiUl/wuKVB9BKgCPT0VMhF27eL/8f59eHAEX8N7hIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcX1ZltdWPjXHOPHaOaQrK3jiB5gJuTyKMjF+yHO9No=;
 b=UK4TRQXiI2Thu0yVZ8dvoi6wbqxXYNZViDH37kBqlCsmF8ys0nVjaNw2aVr2HihJsG7aiprmx9dL9dLFTSt89SS0d2SFegi7MkKTaYpogqrwkkYM/kb6I7SfV5lWUlMbXl5ZpKGgXI0J3EtyOemrzzSO6jWG3nlm0bFwgowNjru4DV0nM+mQVOMOfJtv4aEHJDyfJTbCVCsqij63+IwF+cLPEDPIl6DD8hotpjsESwdeROjNJzKJuTYzx9M052oKoPOWalhfTPE0auuYIPXe7rCo/kZ5DYqACh+P/P4Dy0XQoV9cGjyb0vwvMpR2MyQS8W1EoKpA20vgCU2ewoFzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcX1ZltdWPjXHOPHaOaQrK3jiB5gJuTyKMjF+yHO9No=;
 b=fzHztsBMo/Qx84i6QYkvmS3O4XIW8vFxscJbG8VHRtiwj7F2vZyrfYHZ2rDaDJvCuOUEVXmrr5JA2L4+H+iCc5hE6gE14UqbIBdN0lswQAPCriIJstU/ZatS2XZhqTOxLcCMRfS17YpeSbrKLt+BVnWHvHryLYQlvWmsKckvcSWGF6q8gZ2KXgTdk8mVtFpCHVTZqSbTpnailoD9qJyDkBnnfrKb4MYAUX8u2kRMDQ4+RtJXzQfn2VbI2YXvtfT7/N7zU40/CgnkHSGFRtnPpijOdIHZM/q0poQigMfzCgSgHFUiKQLG7Wsd6fbpidYDTexBUPx9AbmeUxzkYslN5g==
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
 20:32:46 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, stefanb@linux.ibm.com, kgold@linux.ibm.com,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 0/3] Load keys from TPM2 NV Index on IMA keyring
Date:   Thu, 25 Feb 2021 21:32:26 +0100
Message-Id: <20210225203229.363302-1-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:ec87:3741:6e9a:b11e]
X-ClientProxiedBy: AM0PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:208:14::31) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.mgmt.home.puiterwijk.org (2a10:3781:662:0:ec87:3741:6e9a:b11e) by AM0PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:208:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 20:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d26061-3e08-496d-11c0-08d8d9cc82fe
X-MS-TrafficTypeDiagnostic: AM4P191MB0083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4P191MB008339860F9BC7694B7E3B59C89E9@AM4P191MB0083.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2LgruPBncOU/DY3bytsoD7fMHapXI0f4G/GS8/Pqod07bLBOcZxxTEsmUr5lHhtzTBhKjRDeM0/JPH9nwEVLn0m2YRDQ2hZgMdlX2cSef/h09nLHJHvWCXzWpT7TtZqTGVnlkRnvBiMwwjMkuXKChIvAyYgtNua0IHTQYvoWPvkBfGypYVhAh7IzSi1jn58NjoxUiGklRqyj14KPck7dttbIFRznF1xMLPhyIiSV/Lw6O2pKpIGkvLyoOenl9y7aA8T3YfqtpZyrZ+1ejZBdSXOVsdeCbL5yMHwH4lvdAnkgFi93H+thyF3lUFn0pJMiGqHC8jphlfsdYSJ+ZUi7palKUiESlEpS/WCoIm2nXGOMIYg+Ba9wtTuS8T6RAau61rhfO/2TqA2PXgTHphw2LYHrckbGk4ZmYWJkPVGSlWdO7Cd9Pf7CmYS5lvY/SKDn/NzvgD9tyXw9HaCvOt7MOT4RdgPhHV6q5kbBsFi4CrjOq5nN/555n+6BjFPg+tNmTo66UvZGAVpVQYYSGBFUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(136003)(346002)(366004)(396003)(2616005)(316002)(186003)(107886003)(6486002)(5660300002)(4326008)(66476007)(1076003)(478600001)(66946007)(6666004)(2906002)(36756003)(7696005)(52116002)(66556008)(83380400001)(8676002)(8936002)(16526019)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lOcD4F9f1BfX+wUmXbMPZCVoZ7xutMsJYQHjGS59mmX8V/KN9zJ6iWqEWN1j?=
 =?us-ascii?Q?X7dNROwbfFngfHL6SXS9t9XS5vSqugN557zCqUwE462s66TpbuLyhIdugnMD?=
 =?us-ascii?Q?SeCf/MEo02kZmKbPiQfcjlrq8gZlELje33FhreXGn4x4ectU7c2bhY31xeFH?=
 =?us-ascii?Q?dthMa+rRkXQ+GBSVzOdWuTXIx0T79O80ASTnTCtFJxgs5/MNegh1ut8NsXfo?=
 =?us-ascii?Q?kpQ6LpJcN2W/6DgH8jI9BPrndMU9sxB7Zc5CqbZBTnvWwulQJRmwnrmzNtcI?=
 =?us-ascii?Q?hJSUiqK6iXMqPtFtK+NrBeMQNnUu83MDDVWEgWfKExBqqQpO34Kvbqjnlq1c?=
 =?us-ascii?Q?UVeJ7aM0Y20EhPEVdZ2z1RhjJdocoqniXm18tme3+GEHiJEzrxO3RWutc1Oe?=
 =?us-ascii?Q?aWKyioo+WHAUw/DjOM0zfTs0E+zVqRDkcXjS7lmDk9VoTAvnFoctLczFHpMl?=
 =?us-ascii?Q?WOvbOo2g3z1QnLrbfJ/l6Kg3ltxJsr8oiswunxzwSNIKAT/YPtsgWGdJVc2R?=
 =?us-ascii?Q?Zd7IZRzVtR+kCQKfNUq/7d4joONj/xQEwGyvXnT7gtPqdiMzWKQt9Wf6ysGT?=
 =?us-ascii?Q?OZpYX+HEUrjX1EcI0L2JcbYt6DMCWE79Z5VOGoxQsShx3iJvT0g7OjvVYkQg?=
 =?us-ascii?Q?p/kaPMyk+GkOD7jtXRPetDnAcs1Y3ncnuYTk3Zgms4FsTU+dv+6KtB7kiTV6?=
 =?us-ascii?Q?nX1OQq1deEBRZOUK9J73v6CToS5HDnxveO0JbUiBC7iIxD17++2joH5bVP51?=
 =?us-ascii?Q?PrC8P+iC9j3AMYU1m365OpqEOSiFglYmjP3fhQuzC1ehlPn7pCBtRllMn20D?=
 =?us-ascii?Q?pttgsca1WLT447CI1kt0kQJZm82Z5kfh+fZ9qB4kBEBQwphzEr53C53p5xCx?=
 =?us-ascii?Q?udjT2aT7rqbLsKe0T4QqEt7otDzbK+gvw4QUAddPzQz1cUI9r0u3xTjpiJnd?=
 =?us-ascii?Q?s5Nns7snBNeja29ECg0KlJsqRAoh2a6DgYABxUv2gf1Wzp1BJAX+4Ye7ee1M?=
 =?us-ascii?Q?TFx4fKoKKXGHPpLxRPrqHw2Wp+nKFJm5Z6YfdFZK3hN5N5CrB3WVpWGyaTnK?=
 =?us-ascii?Q?5KufqrU57ErfVVmLcw5U8/VYvHYBeaqsAuNldyY5RTgFqxGTjKxr+tusK7Qp?=
 =?us-ascii?Q?PlJVaKzL/VBUVfe4cj1IiyoeUPB9SsTzD7on1/w/A7e8jstH2LyNTzcX37IN?=
 =?us-ascii?Q?SdNvKVCAAgOCRi47FCw1r1l6Gk35tFF/hbfP3UmccP0Em5bd/9fqxXs4I4R7?=
 =?us-ascii?Q?K5ITgzuGL/jdNBdnJRy1lwo5oPva4z7nSFCpapKQhKRuuJKf4MM+GlH6pJ4F?=
 =?us-ascii?Q?eQRbsdGsNeiODAUxji3LMmWer6/LjsiUxBmnImumv8F1dY+maU1Kjl2DfGRu?=
 =?us-ascii?Q?u45EK2B1vxKCicjpoP86lE6EHOLe?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d26061-3e08-496d-11c0-08d8d9cc82fe
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:32:46.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfdEkUA6Fppt/nAhU22mlnKHj1u2Ea7EEGRTXfUSDNOq5Nflr5yXRfyRxGdSDUuH2gpw/tz13j1qUIQ+p/IU8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P191MB0083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The system's signature chain of trust is rooted in hardware and pivots to
the keys baked into the kernel. IMA maintains this signature chain of trust
by requiring any key being added to the IMA trusted keyring to be signed by
a key on the builtin (or secondary) keyrings. This prevents a local key,
needed for signing policies or other files, from being loaded on the IMA
keyring, without requiring a custom built kernel (or injecting a key and
resigning the kernel image).

Allow users to load their own public key stored in a specific TPM2 NV
Index, requiring the absence of the Platform Create and Platform Write
attributes on the NV Index, to be loaded on the IMA keyring.

To test this with the TPM2-software tools with a DER-encoded imacert.der:
  tpm2_nvdefine -C o -s 945 0x184b520
  tpm2_nvwrite -C o -i imacert.der 0x184b520

Or with the IBM TSS tools:
  tssnvdefinespace -ha 0x184b520 -hi o -sz 945 +at ow +at or
  tssnvwrite -hia o -ha 0x184b520 -if imacert.der

Then after a reboot, the ima keyring should contain the certificate.

Note that if this feature is enabled, users should make sure an NV Index
is created with accurate attributes to prevent any other users from
writing or deleting the NV Index. Without this precaution, any user who
has access to the TPM would be able to write a key to the NV Index and have
that key loaded on the IMA trusted keyring.

A distro who wants to enable this feature, for example, should ensure that
the installer defines the NV Index in all cases, and only fills it if a key
was provided by the user.

It is strongly adviced that any NV Index created for this purpose has at
least the policy_delete and policywrite attributes set, together with a
non-empty policy. Those flags make sure that the policy (which would be up
to them to define) is required to be satisfied to delete or write the index.

Patrick Uiterwijk (3):
  tpm: Add support for reading a TPM NV Index
  integrity: Allow specifying flags in integrity_load_cert
  integrity: Load keys from TPM NV onto IMA keyring

 drivers/char/tpm/tpm-interface.c              |  30 ++++
 drivers/char/tpm/tpm.h                        |   5 +
 drivers/char/tpm/tpm2-cmd.c                   | 163 ++++++++++++++++++
 include/linux/tpm.h                           |  65 +++++++
 security/integrity/digsig.c                   |  11 +-
 security/integrity/ima/Kconfig                |  22 +++
 security/integrity/ima/ima_init.c             |  53 ++++++
 security/integrity/integrity.h                |   6 +-
 .../platform_certs/platform_keyring.c         |   2 +-
 9 files changed, 349 insertions(+), 8 deletions(-)

-- 
2.29.2

