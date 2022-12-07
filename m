Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D68645FD3
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLGRNq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLGRNm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81528654E0;
        Wed,  7 Dec 2022 09:13:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDZ9N030068;
        Wed, 7 Dec 2022 17:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=byeCCAYaQNZUBhaHGZg5pa+uclSs0ju7EEBBpjSBS7E=;
 b=B4y9YNIv8S7oTP7BJ//rCiiou/0S1PSNUZYdVbDqnUy/XlnKaWP4yLJAzTJ/6OxGCJQk
 GR6LM+6cWBaakhLNc/OjGDTsXwll1tfiyNjjWZrgbguMR5mP2ZUY3VUTcvduEhZcK4aw
 W04SX2I/ywbqCwDZQDOdWNLvO5Tuuwq3nC6gA4eX4epZhG+HRbmDCMYB3h7zLmXviChT
 FmNJvd5bPF1umupzkpCtrLrtBsIr6HfdqVXYu4mUH0EtppDXWd6+m/1eeKkpBg/tRRvO
 PjUtJ3WOnzMS+2+be8F9h3YJP+pCwY6QO0SLHC4Hds+iy+KSex4rGlSQezwWbY2ziZr4 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudk8vqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwTtx016008;
        Wed, 7 Dec 2022 17:12:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4qacyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb7BAO2ET5O8O83iw/Edve4UANqFUiv+XHJ1t4Q8o83pQpI0jjHatGbm3gKzIzp9lehJj7o47feXdZJppxv9VZyH9aR0bAazf3ICsMCHuTMvSDwiBMF+jz9smiXofz0XTZRmONFa2b1vhlpfpd5rtyur0BNl+9oJTlzc5hRjUtBh3+OWcb3p7echigEska55xfT14539mO2KfSzZuFDvyihN32NPKmRutKB5EoWys7suwqpq1naYLmFMTAnZwQRCzcJM2gj1IUSN74M5fn/+PxRFi3TiQfvd5OpDAKsLmTlT/0PMKuhSyWRHrrwm6pvdJahn7M9aYckYhGnxcHOBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byeCCAYaQNZUBhaHGZg5pa+uclSs0ju7EEBBpjSBS7E=;
 b=g4m87xLrz+Om8xQOGabCGECthNRsz+NaLlBUYc1M6olWYE5nMhstkXSx67iFuNVUjZ8EqbcZLHkk6RSCgHJmPW3lLBj9mVBU1n7KC5ov/oaO5aadcXCpnjFIAOpT8iyEc0WGHvBbWKw4kiodU7u2vL2cUpCn0wrrPrjVrLAV8B2yOoR8i/MHjCX5nhkDLrUZL83nx3ipqqwIV79WAMx0AhEl4PxLKx+/mAnCBwr/N5AlAQwkqxBh9ZjRssJlrpDhB4FbtP67AXf1tJBXmo8bQxRjjequo9afteYmkfPxt2ILeU9VhVJYUvhC5wzonvJfMiRpgC8Fd5+Aqq0Mk2tmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byeCCAYaQNZUBhaHGZg5pa+uclSs0ju7EEBBpjSBS7E=;
 b=feEI7BZNTSW89IoK9wLgdvlbaqU6JT4uHWh5jHoCsL4jqZLssHVoJPqiB+b3G7gIXIPDsB5geCNKWitOiyqi9MT0aG+RaFF5sFNmRKkv6Y7DYa8W9rqXaj28iXc3fWgyF4Gsmgz8e5CKauPvthdDEYPcdM6a4IQ2boGt7qcYf94=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:37 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        bp@suse.de, eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 00/10] Add CA enforcement keyring restrictions
Date:   Wed,  7 Dec 2022 12:12:28 -0500
Message-Id: <20221207171238.2945307-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: f4069506-8488-40db-217b-08dad8763d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OVjvi5dkPCRZJ3NuoczgxOZ3SypelKeKrKYgO9fAfdvb1d1IoV9j+EuJE5bmdkDdTmNbLUjwB+x6vmGm85GXqorDKUIpb3574+Yv63zcWLta5zg/6oLBPf6KGFe/Gf4+lyTcV/shtUDdZF0lNF52VFdtVV5gOWc51mdh685igNiAdhEjCSshoynNyZ03+KVsY1k8Qzwn0gvf6hx0QSXwQvfTIQ8ZD2OxbiWqnX8py0nMXECDBFqr+WaXbOfSV61GKNub4x6xXzMcz1TW5X+yBiTPimsi3bMhnjgSdp5+DHn/uxcrzs4xsSH0ffuzG8qyylzxCO7G2Izdz60QTsPm7gOHnB2kdPSGUhh6XuW1GE4c91F9hub8SVOXwhY4TAG3Z2pg/QbpSPcgu/B8DBxp/mQvrNaxOdsxkN16AmHI2D6izhxwcFpjAkrQVE4Y3eMsM/uzgRg+7t/0f8IZ3hBcORx5CtR2RgGrwZeTjPuZ7NY6LI4RkrPHq/F3q3LBAoJsHTfJ0lbowNCFyQ1y4qVzObKMrUIi5nODurPL/p8u8+SndbbJ4YNkprcDx1KQ8x06McIoPUlRyQA/x5DC5m+OndDgJ4aQ6A8blrzglWCj9yMvD7cswkIC+6ey4Ya1W8GJqnEVreanBq6gCG2Dpq8iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7DXs3vMutaLB1IxKeCMeEZFxvf9oG7psyFwzxFDYGfMhA/OfyKFbUe6R0Rjy?=
 =?us-ascii?Q?H3yzX7v/cFVzPZBiEWelK1WYZ7OasB3xlt3CS3pjqr/WfRYOSfbvHpmnn3RV?=
 =?us-ascii?Q?TZnG+azpaCBiluAsTKN2HchKCoeuKTN3J4dalZn/0YYblHA8YddqSoTAZN7P?=
 =?us-ascii?Q?vspIPZMbyQkcZy7K91qtu4W4hGdF2gX5ZMKP/7P+X6cuPCE9vD+4x6wUCm9s?=
 =?us-ascii?Q?Hhqh84c8hwfXa1PIwaGafDrPgKma+psRNVTd/HfWPAwR9apZgxMrDjTRBxZC?=
 =?us-ascii?Q?lgyIoXM+3kWHRYGNJby5Rk/vtfbU5sQ8mt61PjU6vy2eJGMr4zJwaECXwc8g?=
 =?us-ascii?Q?Pn5ZF9KuThOsMoOQwQppqj/K9COWhylMf0MGeCCDYR+6cQYd8JYCYshWlBaF?=
 =?us-ascii?Q?rzXrZuESeqDrgrQlIfjqdqHktlZvGMQT7yg4dHUTz8wvb6vVrLGj5vhJsJ74?=
 =?us-ascii?Q?fk8VgGVky9OXx8G5ntryow1G3x6z7RLiR5AlZdxzUFkKRM4ZcXPOqpAsjBgd?=
 =?us-ascii?Q?9/ZSdttHkcAcWS0sulM/zSX9AMCWOtGIhbZTmqaPX56Ovn32YUHBWAPAJkUP?=
 =?us-ascii?Q?gS9DaUk3BXXZT1LF3BhsP7eabzqtXiJmTkpzkFRL1QD1EJs7Y/Yd7KBzbTYP?=
 =?us-ascii?Q?5nsa9TQYAhP6Zl5mIQNheIiwzdfLoO91HslG2TKVV/MNvrr3Mi2tf84Ckv51?=
 =?us-ascii?Q?dpiEGMeEPGte+xNijsYoYAsOcZyg5NrQEF0kVw5Ow/lYGF6FeH3TonXDfwC9?=
 =?us-ascii?Q?HJ+m12cpzeNT3H/Dxz/PVZ7MSDX0CtKoCsCTuOjB7VQdfX1aD2JvDrupw0vd?=
 =?us-ascii?Q?YBT4XrZ/T1v1K2iWQQoCfeit2ztBI1cRDKN4iO+hIMPxIWqhmQYs+CDXMOSY?=
 =?us-ascii?Q?rsYymdF3s57mzGQucosYUXWoFjig0/PMG9Vmfkc4lgcNx2vKVnL3CT8YJuYv?=
 =?us-ascii?Q?8J9I13KoRGh+/1E3E4/WYP5VBlNLTMRuiOXycRbPWmo01PMIOKLuuDhnCr7q?=
 =?us-ascii?Q?XpGWDNUiBLu/c8wlBLtPowLCy1Vzq5mksnjLAnlVcR8atauNyMU2y2A02kAC?=
 =?us-ascii?Q?gEs86C/0AZxKgwE3cf4MXsLLN/+YhlWoma7mDuApq8UqYIOKQ0WUjOw5PTYb?=
 =?us-ascii?Q?/SdPKxgal0UWHqTfRQ8Z6qEMrZ23sQ+Wnhh/D+hGSut2lCpb5nzds56+9ENv?=
 =?us-ascii?Q?rqipDp5nTk/XMeQp336qEhgBraHQQ8eyggR23c5AxVGzoe5xyqnn8r8XAgCW?=
 =?us-ascii?Q?NoJhIqPDLc2N8eW3n62O0ulrDHaXXK3s8KfeEQrJn6C4aOgw9uA1E1DSfkca?=
 =?us-ascii?Q?SglijtHPV4zxIXzGs0w9WHsdsZ3hyVHfJ4z5GEx00vWtXfM5Wcg5tthqBkCD?=
 =?us-ascii?Q?UCNgeTSDAxUuzHdncrZgnc0xosnvKgpeyuK5IxKrlAFcUxzvYC6qvJhdmGp5?=
 =?us-ascii?Q?hPlkNTsY3MuCQOGh0V2zruz6J5WxRcFfOeqMk0sEp7DFI/8Te4sibNC6BdnH?=
 =?us-ascii?Q?hHtfJEip4QQLb3i54tsoDUmxFBs26qZzB6wHQD+eUAV/Gy3izzp+XN9exYw8?=
 =?us-ascii?Q?YS/pNt0dcNfPNIhlnco+gnVfE2Q7AFnVgDAnkHbI7/gHzMBO5DC0oxpmff2N?=
 =?us-ascii?Q?EP1s703GXdhCUmSqoQOd8Ao=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4069506-8488-40db-217b-08dad8763d5a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:37.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wvvNNP4iybtqqQQeKAJQtVS/MJWO0et6oo3TMon317L79XQPUg9c4ILn23nDtnCCb3L4ZJhyuQsD72FPLwvbyZwqPoFWrLDEwUrZCiBRC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=842 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070149
X-Proofpoint-GUID: f6emVa1Uaf0W91-vQySQcGinhSWT_8sc
X-Proofpoint-ORIG-GUID: f6emVa1Uaf0W91-vQySQcGinhSWT_8sc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to the introduction of the machine keyring, most distros simply 
allowed all keys contained within the platform keyring to be used
for both kernel and module verification.  This was done by an out of
tree patch.  Some distros took it even further and loaded all these keys
into the secondary trusted keyring.  This also allowed the system owner 
to add their own key for IMA usage.

Each distro contains similar documentation on how to sign kernel modules
and enroll the key into the MOK.  The process is fairly straightforward.
With the introduction of the machine keyring, the process remains
basically the same, without the need for any out of tree patches.

The machine keyring allowed distros to eliminate the out of tree patches
for kernel module signing.  However, it falls short in allowing the end 
user to add their own keys for IMA. Currently the machine keyring can not 
be used as another trust anchor for adding keys to the ima keyring, since 
CA enforcement does not currently exist.  This would expand the current 
integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
Kconfig states that keys may be added to the ima keyrings if the key is 
validly signed by a CA cert in the system built-in or secondary trusted 
keyring.  Currently there is not code that enforces the "validly signed" 
CA cert. Any key in the builtin or secondary keyring can be used.  Also, 
the definition of "validly signed" has never been stated, leaving this up 
to multiple interpretations. 

To allow IMA to be enabled with the machine keyring, this series introduces
enforcement of key usage in the certificate. This series also defines a 
"validly signed" CA cert and applies the same definition across all
kernel keyrings.

The machine keyring shares  similarities with both the builtin and
secondary keyrings.  Similar to the builtin, no keys may be added to the
machine keyring following boot. The secondary keyring allows user
provided keys to be added following boot; however, a previously enrolled
kernel key must vouch for the key before it may be included. The system
owner may include their own keys into the machine keyring prior to boot.
If the end-user is not the system owner, they may not add their own keys
to the machine keyring.  

The machine keyring is only populated when Secure Boot is enabled.  A
system owner has the ability to control the entire Secure Boot keychain
(PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
With this control, they may use insert-sys-cert to include their own key 
and re-sign their kernel and have it boot.  The system owner also has 
control to include or exclude MOK keys. This series does not try to 
interpret how a system owner has configured their machine.  If the system 
owner has taken the steps to add their own MOK keys, they will be 
included in the machine keyring and used for verification, exactly 
the same way as keys contained in the builtin and secondary keyrings.
Since the system owner has the ability to add keys before booting to
either the machine or builtin keyrings, it is viewed as inconsequential 
if the key originated from one or the other.

This series introduces two different ways to configure the machine keyring.
By default, nothing changes and all MOK keys are loaded into it.  Whenever
a "validly signed" key is found within the machine, builtin, or
secondary, a flag indicating this is stored in the public key struct.
The other option is if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is 
enabled, only "validly signed" CA certs will be loaded into the machine 
keyring. All remaining MOK keys will be loaded into the platform keyring.

A "validly signed" CA cert shall be defined as any X509 certificate that
is self signed, contains the keyCertSign key usage and has the CA bit
set to true.

With this series applied, "validly signed" CA enforcement is in place
whenever IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled.
Meaning, before any key can be included into the ima keyring, it must be
vouched for by a "validly signed" CA key contained within the builtin,
secondary, or machine keyrings.

IMA allows userspace applications to be signed. The enduser may sign
their own application, however they may also want to use an application
provided by a 3rd party.  The entity building the kernel, may not be the
same entity building the userspace program.  The system owner may also
be a third entity.  If the system owner trusts the entity building the
userspace program, they will include their public key within the MOK.
This key would be used to sign the key added to the ima keyring. Not all
3rd party userspace providers have the capability to properly manage a
root CA.  Some may outsource to a different code signing provider.  Many
code signing providers use Intermediate CA certificates. Therefore, this
series also includes support for Intermediate CA certificates.  If a
"validly signed" CA can vouch for an Intermediate CA, and it contains
the keyCertSign key usage, it will also be flagged as being a "validly
signed" CA. The Intermediate CA certificates could be loaded into the
secondary keyring following boot. Afterwards, CA enforcement is
maintained for any key added to the ima keyring.

This series could be broken up into 3 different parts.  The first two
patches could be taken now.  They solve current issues that will be
triggered by the build robots.  Patches 3-8 add CA enforcement for the
ima keyring.  Patches 9-10 restrict the machine keyring to only load CA
certs into it.  Patches 9-10 require all the previous patches since
Intermediate CA enforcement is required. 

Eric Snowberg (10):
  KEYS: Create static version of public_key_verify_signature
  KEYS: Add missing function documentation
  KEYS: X.509: Parse Basic Constraints for CA
  KEYS: X.509: Parse Key Usage
  KEYS: Introduce a CA endorsed flag
  KEYS: Introduce keyring restriction that validates ca trust
  KEYS: X.509: Flag Intermediate CA certs as endorsed
  integrity: Use root of trust signature restriction
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca

 certs/system_keyring.c                    | 30 ++++++++-
 crypto/asymmetric_keys/restrict.c         | 81 +++++++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 31 +++++++++
 crypto/asymmetric_keys/x509_parser.h      |  2 +
 crypto/asymmetric_keys/x509_public_key.c  | 16 +++++
 include/crypto/public_key.h               | 30 +++++++++
 include/keys/system_keyring.h             | 12 +++-
 include/linux/ima.h                       | 11 +++
 include/linux/key-type.h                  |  3 +
 include/linux/key.h                       |  2 +
 security/integrity/Kconfig                | 11 ++-
 security/integrity/digsig.c               | 12 ++--
 security/integrity/ima/Kconfig            |  6 +-
 security/keys/key.c                       | 13 ++++
 14 files changed, 249 insertions(+), 11 deletions(-)


base-commit: 76dcd734eca23168cb008912c0f69ff408905235
-- 
2.27.0

