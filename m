Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7F3E49E5
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhHIQcD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5648 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231675AbhHIQbt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GBn5J024019;
        Mon, 9 Aug 2021 16:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=/gFzrqJn+dM5efejD7xhJ66JLsD8/FyeGSNSO5SBvPA=;
 b=l2iuzZ6TN4cC2W9QUQ5VQaN1dFxODYcaA/USJxaDk0aOQ8gz+EjExsg7+12rWWejwANM
 e6b/5ZuJT+dQTONqs2HIJl2hmEoe6Oc299C7ZFYgR5at5Afsn6LwXD4MXr8BDj+xH/07
 zopo2LTRqEknIwaW+x+yBSE0JUY6BSyWH5FKw7uRnckCOZD0oYXO3Y0GE4SOMEk3uZhi
 6b7BP7f95Y36YjWom0gM8m/3cPRwh13icnTOfZ/iwh6HpD5/CuqfshpeKwNAkNdL3EFB
 0+6hMH48rfSKdNz3IbF9quid+UFt2NSYqKNBNKT/bheaWgR1LOAPDVM/WFibUcQ3u7hN LA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=/gFzrqJn+dM5efejD7xhJ66JLsD8/FyeGSNSO5SBvPA=;
 b=TECo3B1VpyRNPeu/zw8k2lJTRIrvwPhhN25+Qg0vIuPF0pv9151pmU3suyTWkSxgAgHG
 vha4lW8NFnxk0YJEHj2MybCdrKn2vhwysLN/P2Dp1AKl5tjZP/lQCmJD9Iih+lvNBLia
 HLQQI/io8i6zpKQP1IrnLtSJwCtg/pFQn4jMCe7GmuvqaHwdTKPiOzLsibedDjgWYe3i
 tc/RgFBnikP+A9lwuHIZ0/XPd89jFoBdin9ugt1p7CoAdlNUJ3VFaBGVBAkbg1yUBef1
 EyAixXV2396VYlh38UOUB/dzU+yHzUR/twp2uey6mYpqVkcPglWjt6nOINW3/mATCyE7 fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fsdss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUmIb180824;
        Mon, 9 Aug 2021 16:31:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3aa8qrm6pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI9rcBVocPI1C1X/dDwl4UnX2lKT7BGb2t61AMUsGbAaY9IGNRM3dRhGhkJA2olzRfIrqv1jd0RO8pWpQeAWXWfOjWTCLSSbcy74nQc3sIW4SEJZ2IjeBpF94MM8ch9H5rfrrU6hDEh9JSMsE5k6/AG1fIet5ob8FI82ZFMVnbu49jM1Qhl/INq1NFiglQSPegfXrAxvJ6YoiOP6JXRuavMQlYjZ0a8S9lhLMbGOXwYCFrGjoSqtk7MJUS/hq7cTwi5lhvvJtgKq6qBGkkwk9idbgjErxvThbjBlBiP/kSgGHCUtJRYk09gcGKRTrP4k0V5scr5HQBUvpu1Rhn+blA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gFzrqJn+dM5efejD7xhJ66JLsD8/FyeGSNSO5SBvPA=;
 b=JxUA8DNoCpPCN49/QtueULO1JE9uhDOL3exmG8bn/dx4jj9CEXP2asQwYzqm7f3MJSuxmQJfkTeLqQ6HqrfLUXc2u/Xs2ZaofUSoK367trj5fR23aXZGAKrw/cWc14ZQQhJw79P7HKr7+wL+iigyZaCveKtm+ksbO/iYMnvs11TiV72vAH7jzKxisPtnZUCyy3bRYacVMgyk/d31M0XlZ8BD2xzxNODlylDnCkOyjWhfjSHHaqlAa3r1bHsFs9iaCol+089QJD8mcn6S9vDias/MfaNW1yuB009SZSCzFXSg+GUpTSLbGeuzVcJndGGpGVLhclO0ZncRz3aoD0ngvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gFzrqJn+dM5efejD7xhJ66JLsD8/FyeGSNSO5SBvPA=;
 b=lR7SOktU+3NSCLp1G9GlvF8EmS6KbarIAb/bz25ydlCnJkcCDwgtl9IEF7HNHxslqELimwflBWOip/sk2xXGjSYdd67ZOTFAJgQecBKkUFaEAKl4RxhE3vNB6ghAN5Bdo+5GmA1vjzQzSRSX5fr0QOpcheJxrLYkqsCYLYocQNY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:39 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:39 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 00/14] x86: Trenchboot secure dynamic launch Linux kernel support
Date:   Mon,  9 Aug 2021 12:38:42 -0400
Message-Id: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8219a504-775a-4ad0-5c32-08d95b530624
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB263134E5F3FF51CCC182A1EBE6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D258tJyKIvHSiM8DXFoI2ugesX9f2JFMEkB5rQRAGn4xvlpEOgRL1phBQV5cYdy4oXTHKOKIjALFw1NnjfGeJNMx81P2O26qbnJU2xyF1iPOX/Je88MhCbKhC3er4J5uBnybc4HHQkOF3LkVZ+yMQl4dCEzPxWBm/QLwYIO2xuCmFfM8cpPtUucDOjcp2HoUNdbT/HqRtDPsP6L5k1YJnBBFkCh+LweQEZl0/akspD7eIx+p3SSXq+bFMsaP/QPwa1PD0Woe4oCnhaF0DdjO2mZwqjiTshNYCIaORk7/ojh9LLNRDG7Wefn8LY9gB0KHfvlW57fbuERNt3R/kPLF7z8YlZz36PW83W51rteaFmJlojAqKEhmpsgXcBpu1tvPCypUpXh4nq/5fWVIy3cGUhqwO7HXSNbu+dbxi/8Kqx/tPHH8UEAJ6Zm9fITktW8+p9db155wfhvQNth/s1mY2B0D/8RZvHUDl4w55YudxXNKoEag9ABjbnYxgvbSwAACHpt6c0/n4TQt/gkWbC3VVYyPiHa9zgpoin9qIZeupbCx3KVju3xDrlFRgtAsXCa5TqmnV5kbEKY3jgh59EK6LYSlPror0d/8iDvy++UNAQyAvcDTgVpDN/IVEF9VlSJ9sfdwlu/zBIaGSOc7Eo2ojOIcdtxtxEl4eH/wwtR4mZi9e/sRgyDPF2tlydNvQn9nzj3we6S1fML54VRf3lOigsz3KNaSVPZTVKO/riyOVqVP5ypz7RKGMq9VDoePaENMzkN6jy569mUOS2evtl8LtmhhFfpT78PClpDGCKV+p3VOc7QvVxYuh8x/GjV60P+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(966005)(6666004)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(83380400001)(66946007)(5660300002)(956004)(66476007)(2616005)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WY+4NfgGgSc+Qv16AiA+/79KARGY0GuXXvKgoJN0+qIvdputNrEkjSMTdr4C?=
 =?us-ascii?Q?+FlnMV+MrOAU0w+BB6FdxGtyCISbn26kkTCB05AAHeLe4x5B9+A48rHhZLK8?=
 =?us-ascii?Q?5agjT5koFMeT8sBs6UWmaX71SU0XmbkS++F08EkdR3VbbE+7Xj/2uTAVLxfx?=
 =?us-ascii?Q?rSwLXIce/fCBl1bvL3VVQ8MTSk5fOTv8wvLMjZ9NNOEiQW55yt0K5P387jK5?=
 =?us-ascii?Q?g3bH0T3+cUFtumtsXVvE0uODkcdoZkAs3vGm6nAoX31jsGExwn5jYfbm/s9t?=
 =?us-ascii?Q?g80f/k9pZoue0vybphzSW8m4Ufk40AcG01qUpDBJNOpqVnKLztVHaxSGu/LK?=
 =?us-ascii?Q?HZrX1pKk2WS3EmXLj2ARzT0zMn5IBi+lws3mtCWIPBzIFtttbJbDc5eVMzka?=
 =?us-ascii?Q?qkC87XNAVIqdbpp82Ee7DHueGW87F5vyy+5ZijGDHRTDLGMqysXdN38AJp8P?=
 =?us-ascii?Q?ukFmdYB+Cw41hv1tqZmRFTHM6I+F1FjwKV67AK8o5M6eEN31ZYmPFlBtJmf4?=
 =?us-ascii?Q?MZ9gaqrTg6Uk6bFrABAsHrIs6qEKREe/ZP2aR0JZy8SgBdYZquPYBN7TH/oB?=
 =?us-ascii?Q?nlPbGO3fmPPVR3RaZ/nLgzejJ/0j898vfpklVa8oee0MdD7hV9KiH2ablkbB?=
 =?us-ascii?Q?GCjPO3tdL2S7rdA5CIYOynU3MlWlUMJLRdp6dx2mKZDWaR7vSvPt+0PqYolB?=
 =?us-ascii?Q?Ugy/uYnObfJSog709uij/EhRSZeYFG6cD7tqdeCPIx6Zv8Mpq/Gt4yDQ2khz?=
 =?us-ascii?Q?RmV7QQpDF/c2NJKmi5ovVRkZ0n4gr4MgPZcuKYPgem8JoNJmjT0WPoUXnSUk?=
 =?us-ascii?Q?sJ1CiCjdNg9x9lzi/qU4QyDuQIl5Fw6vDioZ2bLjlBRjtp8T5jiwePh2E06w?=
 =?us-ascii?Q?63OUySV9wzscRxNPmXyYV62aMTs2PdLoZhILU0tAk9tjgxAZk1P5jXI3A0H6?=
 =?us-ascii?Q?bQuj4r+JE9hy6CSmenObQ27rijqRbKBMzMVgvUAN56/azJZQzITJ1MjFSXh1?=
 =?us-ascii?Q?h+NCzw1teyq7c6JVg8PvLxJadVmBVrwU9vc073oEFKli5kqARHJNLbx0drvw?=
 =?us-ascii?Q?eUwjDYKK6Q2H/j35/DvUm8hYiRYUnqS11WHyWORQckUngTJd0se6ZFeQ0mqP?=
 =?us-ascii?Q?zfBXnIPA6nkW1nLLTiRaxtl7kDaGmM1+Z04KxgRTNfK/P+tEhm+LU2bCrl3r?=
 =?us-ascii?Q?gmbo9VXrn0vSzwK2mGGe6I6LK2yAg9vzm74RyaWT3p6DezSnhWRwiXffXWQc?=
 =?us-ascii?Q?I7Sez7ufQv/7FTE/W75SQJy70EPuLbxwn0V3Dc4PlSn8pMYm19Hk41nCvavb?=
 =?us-ascii?Q?w3/XZCQx8ki11Ds1Rmn94Www?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8219a504-775a-4ad0-5c32-08d95b530624
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:39.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6JkGZ/mC3EJyLcoGDs7NFMWA8yUCBffKE9F0pSiIvs90sktRcOcibTAGkhF69wg8tteLpRir2h4ZyVNVZwdmQsSh8v0kFDIaFmdehrvUh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: BEf1krzVs1RTZOpZUu0q6tokDAcKPi4t
X-Proofpoint-GUID: BEf1krzVs1RTZOpZUu0q6tokDAcKPi4t
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The focus of Trechboot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity. This requires the linux kernel
to be directly invoked by x86 Dynamic launch measurements to establish
Dynamic Root of Trust for Measurement (DRTM). The dynamic launch will
be initiated by a boot loader with associated support added to it, for
example the first targeted boot loader will be GRUB2. An integral part of
establishing the DRTM involves measuring everything that is intended to
be run (kernel image, initrd, etc) and everything that will configure
that kernel to run (command line, boot params, etc) into specific PCRs,
the DRTM PCRs (17-22), in the TPM. Another key aspect is the dynamic
launch is rooted in hardware, that is to say the hardware (CPU) is what
takes the first measurement for the chain of integrity measurements. On
Intel this is done using the GETSEC instruction provided by Intel's TXT
and the SKINIT instruction provided by AMD's AMD-V. Information on these
technologies can be readily found online. This patchset introduces Intel
TXT support.

To enable the kernel to be launched by GETSEC, a stub must be built
into the setup section of the compressed kernel to handle the specific
state that the dynamic launch process leaves the BSP in. Also this stub
must measure everything that is going to be used as early as possible.
This stub code and subsequent code must also deal with the specific
state that the dynamic launch leaves the APs in.

A quick note on terminology. The larger open source project itself is
called Trenchboot, which is hosted on Github (links below). The kernel
feature enabling the use of the x86 technology is referred to as "Secure
Launch" within the kernel code. As such the prefixes sl_/SL_ or
slaunch/SLAUNCH will be seen in the code. The stub code discussed above
is referred to as the SL stub.

The new feature starts with patch #4. There are several preceeding patches
before that. Patches 1 and 2 are fixes to an earlier patch set that
itroduced the x86 setup_data type setup_indirect. Patch 3 was authored
by Arvind Sankar. There is no further status on this patch at this point but
Secure Launch depends on it so it is included with the set.

The basic flow is:

 - Entry from the dynamic launch jumps to the SL stub
 - SL stub fixes up the world on the BSP
 - For TXT, SL stub wakes the APs, fixes up their worlds
 - For TXT, APs are left halted waiting for an NMI to wake them
 - SL stub jumps to startup_32
 - SL main locates the TPM event log and writes the measurements of
   configuration and module information into it.
 - Kernel boot proceeds normally from this point.
 - During early setup, slaunch_setup() runs to finish some validation
   and setup tasks.
 - The SMP bringup code is modified to wake the waiting APs. APs vector
   to rmpiggy and start up normally from that point.
 - SL platform module is registered as a late initcall module. It reads
   the TPM event log and extends the measurements taken into the TPM PCRs.
 - SL platform module initializes the securityfs interface to allow
   asccess to the TPM event log and TXT public registers.
 - Kernel boot finishes booting normally
 - SEXIT support to leave SMX mode is present on the kexec path and
   the various reboot paths (poweroff, reset, halt).

Links:

The Trenchboot project including documentation:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

AMD SKINIT is documented in the System Programming manual:

https://www.amd.com/system/files/TechDocs/24593.pdf

GRUB2 pre-launch support patchset (WIP):

https://lists.gnu.org/archive/html/grub-devel/2020-05/msg00011.html

Thanks
Ross Philipson and Daniel P. Smith

Changes in v2:

 - Modified 32b entry code to prevent causing relocations in the compressed
   kernel.
 - Dropped patches for compressed kernel TPM PCR extender.
 - Modified event log code to insert log delimiter events and not rely
   on TPM access.
 - Stop extending PCRs in the early Secure Launch stub code.
 - Removed Kconfig options for hash algorithms and use the algorithms the
   ACM used.
 - Match Secure Launch measurement algorithm use to those reported in the
   TPM 2.0 event log.
 - Read the TPM events out of the TPM and extend them into the PCRs using
   the mainline TPM driver. This is done in the late initcall module.
 - Allow use of alternate PCR 19 and 20 for post ACM measurements.
 - Add Kconfig constraints needed by Secure Launch (disable KASLR
   and add x2apic dependency).
 - Fix testing of SL_FLAGS when determining if Secure Launch is active
   and the architecture is TXT.
 - Use SYM_DATA_START_LOCAL macros in early entry point code.
 - Security audit changes:
   - Validate buffers passed to MLE do not overlap the MLE and are
     properly laid out.
   - Validate buffers and memory regions used by the MLE are
     protected by IOMMU PMRs.
 - Force IOMMU to not use passthrough mode during a Secure Launch.
 - Prevent KASLR use during a Secure Launch.

Changes in v3:

 - Introduce x86 documentation patch to provide background, overview
   and configuration/ABI information for the Secure Launch kernel
   feature.
 - Remove the IOMMU patch with special cases for disabling IOMMU
   passthrough. Configuring the IOMMU is now a documentation matter
   in the previously mentioned new patch.
 - Remove special case KASLR disabling code. Configuring KASLR is now
   a documentation matter in the previously mentioned new patch.
 - Fix incorrect panic on TXT public register read.
 - Properly handle and measure setup_indirect bootparams in the early
   launch code.
 - Use correct compressed kernel image base address when testing buffers
   in the early launch stub code. This bug was introduced by the changes
   to avoid relocation in the compressed kernel.
 - Use CPUID feature bits instead of CPUID vendor strings to determine
   if SMX mode is supported and the system is Intel.
 - Remove early NMI re-enable on the BSP. This can be safely done later
   on the BSP after an IDT is setup.

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (2):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (11):
  x86/boot: Fix memremap of setup_indirect structures
  x86/boot: Add missing handling of setup_indirect structures
  Documentation/x86: Secure Launch kernel documentation
  x86: Secure Launch Kconfig
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch

 Documentation/x86/boot.rst              |  13 +
 Documentation/x86/index.rst             |   1 +
 Documentation/x86/secure-launch.rst     | 714 ++++++++++++++++++++++++++++++++
 arch/x86/Kconfig                        |  32 ++
 arch/x86/boot/compressed/Makefile       |   3 +
 arch/x86/boot/compressed/early_sha1.c   | 103 +++++
 arch/x86/boot/compressed/early_sha1.h   |  17 +
 arch/x86/boot/compressed/early_sha256.c |   7 +
 arch/x86/boot/compressed/head_64.S      |  37 ++
 arch/x86/boot/compressed/kernel_info.S  |  53 ++-
 arch/x86/boot/compressed/kernel_info.h  |  12 +
 arch/x86/boot/compressed/sl_main.c      | 549 ++++++++++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S      | 685 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +
 arch/x86/include/asm/realmode.h         |   3 +
 arch/x86/kernel/Makefile                |   2 +
 arch/x86/kernel/asm-offsets.c           |  19 +
 arch/x86/kernel/e820.c                  |  31 +-
 arch/x86/kernel/kdebugfs.c              |  28 +-
 arch/x86/kernel/ksysfs.c                |  56 ++-
 arch/x86/kernel/reboot.c                |  10 +
 arch/x86/kernel/setup.c                 |  26 +-
 arch/x86/kernel/slaunch.c               | 531 ++++++++++++++++++++++++
 arch/x86/kernel/slmodule.c              | 495 ++++++++++++++++++++++
 arch/x86/kernel/smpboot.c               |  86 ++++
 arch/x86/mm/ioremap.c                   |  34 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/trampoline_64.S    |  37 ++
 drivers/char/tpm/tpm-chip.c             |  13 +-
 drivers/iommu/intel/dmar.c              |   4 +
 include/linux/slaunch.h                 | 532 ++++++++++++++++++++++++
 kernel/kexec_core.c                     |   4 +
 lib/crypto/sha256.c                     |   8 +
 lib/sha1.c                              |   4 +
 34 files changed, 4108 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/x86/secure-launch.rst
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/kernel_info.h
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h

-- 
1.8.3.1

