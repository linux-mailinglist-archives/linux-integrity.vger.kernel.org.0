Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0393F997F
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbhH0NWJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24768 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245185AbhH0NWC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RAGhBv024236;
        Fri, 27 Aug 2021 13:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=UI/MoM4TUAzW1zO07N5apqi3mvniO5GmH11xURogTmg=;
 b=JrENZZmQvey1XgGFioVnf+u9GQ74Y7qI0dBtC5iK+ToZdxK3j/MbBPQJCFCMAnBJ2ybG
 /5HFJNfBvbodxdtRGzL1nN3h+DxxtZmNA2nsJkRkjifpPsNUcqpoQipR3CBFJiXEZy9e
 imlaUq5FkIfhxsEcmxSBhTRfow/KD61Di20n6aQkqAp3jcYSWml+uuJm7qqRzYrrNOs9
 x3Uw0mI+P4Ry2LuSNe5tX/xurMnoPcYg+iTxme2Laj2E+/a1oWnbT+tAFPbaEeaNyZAA
 2l5wTPo5jsxFssZastumthuKiJYSoF41KXVxm0MqtTBC1TRpXwoNHK80K/iN7aPTApqY Og== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=UI/MoM4TUAzW1zO07N5apqi3mvniO5GmH11xURogTmg=;
 b=s6t4k5NE+OqbvW+zuK5BhmNENQ/uWJJ1TX3j3aJOlDjbDM+HdO+GatrKsrNTO+tmesiW
 XeRcL18uzH10cS5dE/NZeuaX38HdySDRq9Mh12/dYn35qndNQiw0yyfD28yJZxOdZ86r
 C8mAKBFP6g/HU1cRHeaoyIKXOZaCd6fwXdU5mQ0+E/ODS4+NNx1sls+TUSUpJKnRuBxi
 UoqgxaHGtUpF5RqxD+PyDal2oOEsZGadfi33N0USsgX7ICUIMm3gAzeRwQNi7ymCVOv+
 bN/FMydpjVbkPlZd6CTMahOVuTlJnxCFsqYuS/Ejnd2lcQLkudSJJAhj3K8ZplUVBGgC bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap0xpbywe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBYUQ007537;
        Fri, 27 Aug 2021 13:20:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3ajqhmjm17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZPaSSCQD8wOv6B4iORGsGLwpql61RY5CXHPCkqsKeKKjIsK6Us39V2dkFK1b1EaMOHnec3KFFImfyMlNp/iXyqXxuJ9JS3t568zHmV251/dcQQBHeqMCZKeFGquJoSuxGhBOn4sLlBB3EirIntl6Ia+DjCtzdj8N9gt7RsokBcnHAUwf3Ivf4Rr/B3nFIGiDtulipMAS7ptTvIo7/nqX5VG67dX+wkDPxYnJxvd6tqliPZsjoXXxuGaAOnlkToVN65OTsNWIzF0i1STkKUNxxPZ9oeju3uWK5lEkYJwsyznkFFzBsqYXQC1MLPN/VVzFFWN970nv1QsZe85Wdk3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI/MoM4TUAzW1zO07N5apqi3mvniO5GmH11xURogTmg=;
 b=RE4GbL3gqqlBTf6KPA1ANpLrm27S6WzTiX/M4KVHso72vmk+9nwiaKTCYBFpyrD8p9/ei5h0lZqWyVPvQmL/SMBBC7y9WVZdtRP478F4F7q0ddQNM6SdEoGQR+zujRtg0Rz3HZ8X4nLnnc5cp/vYVUFyeXDyR3Gv4VTTHuf2WS4jhbDHwAY8gYAmgmBSbZEFnNs3IMux2Lyv0HxkQK4XTD59gL2dN+/ydvPKOS8SfKZJCSpPY1R/JKZ7vs/R8s/Fuva98vseI9AE55KAgh/CQfPNLZjWZiCEwgeH6LRwgEXXoFBxZ8t6UFOyzIacjZPEm0TMqKMtZIel88x8uLxcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI/MoM4TUAzW1zO07N5apqi3mvniO5GmH11xURogTmg=;
 b=ZglFZ2+u5VgnBw3h2V/xoJoYubYFBygbkXOV6wjkCSYV75zAHbXUyxMus0AOv+FGQUCsnYNip/3sH+sQH7q1xzG15DiwceSf9pYwFfa/A0KYsO6ZcsziG7EL6FWg6onFL4M/ue6hAi5v/dSvWDEqhDauqPiFqgjCWkoqICiHXAs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3621.namprd10.prod.outlook.com (2603:10b6:a03:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 13:20:36 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:36 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux kernel support
Date:   Fri, 27 Aug 2021 09:28:23 -0400
Message-Id: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf3d5778-07ee-457e-5f36-08d9695d74ce
X-MS-TrafficTypeDiagnostic: BYAPR10MB3621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB362167FAE2DAE90D812A65F9E6C89@BYAPR10MB3621.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNs0UKm03vJcqvd2TvYRW9dvpE51d3NRYwxU/YBMHQCLbCmyQo2737wIaLIGi21T108UM41WWKXCX5xb1uh9H2mE5BbwCFBljIYcO1PPXjkbaByv2bSXB33lA4IseM4WsWtDUVWmvysdIkTuUdzV/nmZFG7Lc/eDl5M8aMnCJxXKJO4rwp+yJMJGlPq9+vo5stkNt38H0LlckKe+L9Py8wJUzjQyZ2MsOEFrGHKeYxEdWuz+8qQcfS94bmCdRc/o0IQPjKOMr/JYVPCCTLwyxPSeuJM7otGgNxyi41qK4g35Ka03zjCBDuGKk6uDxgNWVIhBHAQR3GM1X8QiexNYzWKtFejLEX1x1g4HL5HPG2ZdwYVlEPb7Z6gydjLTk2Jhxw8PdlLPyur2EoOoIyLCZbxwEo3hxKedMUPZX2idljWUEfWQrGBkcaHiyPpPIJKv8KeZhR5Qc0OEicXXNA1jygNgHR+Z4QNo2wOXw3qC9PZxNm9V0XjElqgSywHrTb8S4ezq7nvYimb/WXkJqu4DErn7mxgbaorfz4pZ2duxJ/nFNbytQLJyMKznbFXvCx50gKHfF7ztCwt6uLjMqJrrDvtq9Pf0chqBzcYxvZ0SANYb6HbxyjOJCDvkN789/JYF7sv9bwikuIoHBrt4mKknA7NYuv7ZwtZ0MAhlutRQ59DmGac7X21Mhtw/OFDRa68ftza6pkgZarUGc9OPM5taftt6T4QJ6Kv3FZ0btcFOE+oAu6swFzEvcCq699ZcPOlNyS343/tIpK3DjLhPCHreo+ly+FtsgcsS7GFiL7vP8/uAE0+dkI3rJV7769i/Rbg2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(44832011)(316002)(86362001)(186003)(36756003)(83380400001)(7416002)(5660300002)(478600001)(6486002)(38100700002)(52116002)(7696005)(30864003)(4326008)(38350700002)(8936002)(8676002)(6666004)(66556008)(2906002)(2616005)(956004)(966005)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiimaAcP6N5n/F85NR2N6zUZqxC534g2Vxse4yhxfQoPDD8qjDM5pj2tNME/?=
 =?us-ascii?Q?8QMa4y3Rg7D+uSXuv9bJzbf2LLoac/yCt53JDPdfgtoG9dHAYi+DHY4s6l2P?=
 =?us-ascii?Q?Js6En5P5D2rps6WBfgqR7B+BTeQE1WwhA4+NoMOc3qFzImB30DIrWbUTme5v?=
 =?us-ascii?Q?8zyo/V+XMqdGtsl8hZggWFZqPZBdWW9Otqe3wPzAWqlfP315g08HnND6B6bY?=
 =?us-ascii?Q?HvBMYTtcG+XrPvlYx4TAEvR8QQtc6umcBvrpKBVyCfoG4pkvZ1gVBTM72d8U?=
 =?us-ascii?Q?M4ux715iwKrtuGVQeTE5IyWkQ2w2RFNj11aGNVBTa5G464rf0aJz+1AIhheq?=
 =?us-ascii?Q?J/PlpIqCR69MSmay8lQSqQCnfJoxSV2lhbVWBd6pYm44v1/1YhGvZvTVj9mK?=
 =?us-ascii?Q?vUCozUptWDgnxZrMdG2Gnm+EOac2vSrKsH7kUihrOZmEdbRSEUzWl7LnVZUN?=
 =?us-ascii?Q?8y1HoOWGQGe5/FqkelH+52S0KETNF7IkQV0wgaS3T1YYe1Ghv+Lc8digwSVv?=
 =?us-ascii?Q?eoP1xBR2cfCBbcOgtucpeUzncQ+Iog7FZKCZE4d5Cd/3TRyQV2KvWpV4Gxhi?=
 =?us-ascii?Q?kkBGEhD06yBQSQGxL5oNDDBySr29em2e79ILkXaJ7kTiP1bv7trSUij0MddQ?=
 =?us-ascii?Q?wwKsM6HLzJpKqjHVvH1IrMF5QVDFSDjroeTHolc/gws5VNBWlyWkRJ0idRUj?=
 =?us-ascii?Q?yaujy5x22S8heSlvaQ8QlNaOQN4yJtiLAQ71HkwU4lda2Wr7qoXJ2TkZ48J0?=
 =?us-ascii?Q?xRwLvdQOvTrZ1iik9Ca0qH1p3yxCtKAa7YJMGMgGvkJtAMaO6Bt2SgczQpMr?=
 =?us-ascii?Q?tYprAi6vg8ujmu5BI9gMyyrpvsrCitdeIO98HrnRLyRVePs0XXM5csEf80WH?=
 =?us-ascii?Q?DfLenXaI7t6EsU+xxOfta4pEF3xQkO3hw9+1Eq8zNdsqIBsieLXDHnjP4dSI?=
 =?us-ascii?Q?1WEIdW+msXUiUt8Q+DmoHOkjfM9ogxGmuKaLPaAtlF2jellqCj7I1Ipgfymg?=
 =?us-ascii?Q?E4HjtLZGzCkAcimb7FG+7ClEiSc9sDcvXK2margKMUxf/MfwOW5FnsYj4wnB?=
 =?us-ascii?Q?FFPFF2pDxHp1bhsL1+DWl1Y8sbOeXeV6QXjm89CjtMy1tQa0Yalx/aE48B3E?=
 =?us-ascii?Q?6CveEwDxcJNnU9C4QkbQjUPNQEOwbf7sY1TnOovIoDwiXns586QKD1OxXX/W?=
 =?us-ascii?Q?zbjoJHYGX0rZ5rXci20ahsnlE45T2e1m7pBQJ46oretIckQ/9y8VfNJo5ZHY?=
 =?us-ascii?Q?jMEM1wkDdKiP33O0NHSCGnsX7Ln3K2NDKY029XQ1pBB5GNpmhNt89ks9O01z?=
 =?us-ascii?Q?LIiR8ABn1aMQt7RQJeDjL3Ph?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3d5778-07ee-457e-5f36-08d9695d74ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:36.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0XHjoGr5vtYR4XtWPY87BCEo0kyxJHaT9TTVzOqwUxzyEjG2NeCnJy4OoAxxE/WpU4Y3ddFw8DZTT/VppQ4UU0pD1GzqpjE9hRw7y8DMws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3621
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: nAkNJboxkyjD9S6WWAavMZ0FO-nJiFzm
X-Proofpoint-ORIG-GUID: nAkNJboxkyjD9S6WWAavMZ0FO-nJiFzm
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity in a unified manner. The first area of
focus has been on the Trusted Computing Group's Dynamic Launch for establishing
a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
Trust for Measurement). The project has been and continues to work on providing
a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
cross-architecture (x86 and Arm), with our recent involvment in the upcoming
Arm DRTM specification. The order of introducing DRTM to the Linux kernel
follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
Technology (TXT) is present today and only requires a preamble loader, e.g. a
boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
been present since the introduction of AMD-V but requires an additional
component that is AMD specific and referred to in the specification as the
Secure Loader, which the TrenchBoot project has an active prototype in
development. Finally Arm's implementation is in specification development stage
and the project is looking to support it when it becomes available.

The approach that the TrenchBoot project is taking requires the Linux kernel
to be directly invoked by the Dynamic Launch. The Dynamic Launch will
be initiated by a boot loader with associated support added to it, for
example the first targeted boot loader will be GRUB2. An integral part of
establishing the DRTM involves measuring everything that is intended to
be run (kernel image, initrd, etc) and everything that will configure
that kernel to run (command line, boot params, etc) into specific PCRs,
the DRTM PCRs (17-22), in the TPM. Another key aspect is the Dynamic
Launch is rooted in hardware, that is to say the hardware (CPU) is what
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

Changes in v4:
 - Expand the cover letter to provide more context to the order that DRTM
   support will be added.
 - Removed debug tracing in TPM request locality funciton and fixed
   local variable declarations.
 - Fixed missing break in default case in slmodule.c.
 - Reworded commit messages in patches 1 and 2 per suggestions.

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (2):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (11):
  x86/boot: Fix memremap of setup_indirect structures
  x86/boot: Add setup_indirect support in early_memremap_is_setup_data
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
 Documentation/x86/secure-launch.rst     | 716 ++++++++++++++++++++++++++++++++
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
 arch/x86/kernel/kdebugfs.c              |  32 +-
 arch/x86/kernel/ksysfs.c                |  56 ++-
 arch/x86/kernel/reboot.c                |  10 +
 arch/x86/kernel/setup.c                 |  26 +-
 arch/x86/kernel/slaunch.c               | 531 +++++++++++++++++++++++
 arch/x86/kernel/slmodule.c              | 494 ++++++++++++++++++++++
 arch/x86/kernel/smpboot.c               |  86 ++++
 arch/x86/mm/ioremap.c                   |  34 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/trampoline_64.S    |  37 ++
 drivers/char/tpm/tpm-chip.c             |   9 +-
 drivers/iommu/intel/dmar.c              |   4 +
 include/linux/slaunch.h                 | 532 ++++++++++++++++++++++++
 kernel/kexec_core.c                     |   4 +
 lib/crypto/sha256.c                     |   8 +
 lib/sha1.c                              |   4 +
 34 files changed, 4110 insertions(+), 49 deletions(-)
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

