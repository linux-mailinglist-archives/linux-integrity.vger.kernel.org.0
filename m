Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF5467A84
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 16:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358039AbhLCPvP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 10:51:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23736 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233978AbhLCPvO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 10:51:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3Feg7P003278;
        Fri, 3 Dec 2021 15:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jaZVfFZPPlGqTTGTOaYEfX/CIPY7dWoKOT1XZ9hHt9c=;
 b=XjQ7SbslGzTfT0himvk78bodYdo26fdeG7mkpYukpKqeDUJ6wlZNQ8zu2QoB1mLpaax/
 pqBq61+MIgiW3qQ0IqlYGC295wBVlea2IN3DldTS3I1anDK7vjl9j2O5MhEYz1i5ZC2n
 GG2Zp9KAuXv+7q+nQPGGQLBRSXiHNSl9oVKiR/zwRUFgvaLQBlnTWeduB+eHlh+CJHKz
 8xSVzHibaVdiHYaPjdtQDWcMHfuM3bYcDTYxfkiFXpXtuNKBZZNgIlxa7MEvyWLXNzlg
 2i8m0TOkqND0yoIsxbk2f2al4IENGJo9GVrWj7Ilw8LxpWOPnGs2qkshVe8BwMcQawz5 Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqmxs8gmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:47:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3FkTWf014176;
        Fri, 3 Dec 2021 15:47:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3020.oracle.com with ESMTP id 3cke4we5sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxfIIPIdNsEiMF9doj2cI122NS6b7fGlQnvksVmxwuCuU/ngRCTpcIj0GTKiQdDnbF22DbQVU59WpFeYJJ9cEv4Fn/IE8BVQeNcJ8vJQiEBggLfLDsaD/7OFNXGFMyXMrqJvmz7YOmxXr+UO99y13ff8i/iSVvgkmXjgNMxBngySYLv82qWaAgV+mqCU5D6eitXP3462XnLlbgxLcX2Kw8gXepalrHKAmsu1OkK7UAgpBIeJNAyasbEl5YUBp9kpR0uxX5ZNIHHXt3XkizsVMoKfs2fO/Bc50Q5mbTI19d81MqyaRMKzupPvQLMkMbF+HvugfJxoXJvgeU/OWVollQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaZVfFZPPlGqTTGTOaYEfX/CIPY7dWoKOT1XZ9hHt9c=;
 b=hfr2VAZ7dAEsM+2BQeow++HL+fi8mU3xpq3MvOc/hqTruvnyWSUsaw5DrErHRgTYMR6ZimmyOhGbA5+yJaPpLokFKF2xoYj23qzr2uI7oPVEnUp6FmjjrGOwXnz9Ax+bojEX/xEacny1t7TNFkXlQNb7sYbs0HPqS3KeANbnwr3zpJxiwYyuWKrjGRxvN8sWlAy65mzbrz5t2kvscNOMhJlr8alzGvXaB1ljX1qqtdHABo4iSGaKR7/Rn+yo4khrO79QPDC1ZAA22yrjCUI5g1Iu5xG6fkJVsYZnmzSACMlAla08KQwrJwM4W+Jh4VHmCKCkb1KTvYkIkldmRjDG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaZVfFZPPlGqTTGTOaYEfX/CIPY7dWoKOT1XZ9hHt9c=;
 b=rWhwNkwBiPI/fJAtiLdNa7URnXm0QBhHwvjGGMm+8DyoaiCCbn8D7lNLhPF7akqldNXeIe4MkjynK0iS7Kfb30QzvHEeANCvHF7kJ+ymcaBAqKaJUcNDVl9J8byrBeEG5PE79j5Lx0hR4TijclFBcrY51XKbr5/joZ5DB6oTRLg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3624.namprd10.prod.outlook.com (2603:10b6:a03:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 15:47:09 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::b46e:493b:14b7:9c83]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::b46e:493b:14b7:9c83%3]) with mapi id 15.20.4755.019; Fri, 3 Dec 2021
 15:47:08 +0000
Message-ID: <6713b6b2-3c6d-8318-ee9e-e1746f02a3a5@oracle.com>
Date:   Fri, 3 Dec 2021 10:47:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 04/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, luto@amacapital.net,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kanth.ghatraju@oracle.com, tglx@linutronix.de,
        trenchboot-devel@googlegroups.com
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-5-git-send-email-ross.philipson@oracle.com>
 <bd677501-bd65-9648-c8f5-1b90983377b5@arm.com>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <bd677501-bd65-9648-c8f5-1b90983377b5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::10) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
Received: from [IPV6:2601:191:8500:cff0::7928] (2601:191:8500:cff0::7928) by BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 15:47:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1aeebe-58aa-479c-b2d0-08d9b67429dc
X-MS-TrafficTypeDiagnostic: BYAPR10MB3624:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3624A01EF61CE6405E4370BAE66A9@BYAPR10MB3624.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKWmf+VAsz4TlkZq+LQjY0W+0evfU8cwqpDHW2oMPH5oWFpJcUta2HVAXlzWYZBa0D/Ew/2r/We6LxD6qQ9GZ8Y2W4UxaBIKRopHa1J82P0DtzWrDjffBhjXkrXiiGlcl9ynONFgRFk2MvckpBLdKqGDEovoRUWaMZMdAO5a0mR+byr65+Sxn4ChAMEX/92gT0TKH3mpvrg9jVoj3HoLvwOGeyRspK98sBH4M2Rw9h3c5AizON8IdYApldxO7dv92u5aXUiWr4emLEfbswS14ZMoQZV9LN3BoNhjTW6YV5fYo876DGkhG0N4vJX0sFRyKD2QnSool5YoNA9pZfV4p/aDT9JBovmRZW6nKRFtMC+oyWkPBpTAFvQXNoJ+eocObBLxcQckR54KEpiULg69MDBFKjvs4pg7Wd8Ko2ICyCRcKGWuvfxUjUAu6x4NyHXV697gRLoLNwA8Hn7LpRV4r6ziI6S+02wL8zG/Qs3yKCyQod0oCmJZ6W/bN5s+RfRpGNEAtU3O3L2F9yiY2aI4r1EaTVOE5phAjLKMFjPCyQ0QhYl8F7B3MX0QxgdpunPPPx3fZ2OfZjESNIa7BUShNyTPO6l4ZfGq0Vtddu7DKn9cvlk5EABnFJjr2cmZcQSiUgDV/HQbmvac0KV72zBKE7PHNZF/BOoo5ym8K2C6X7+x9M0ZpUgtB5H4Y59ZDeJdGsiLjtRGKpn4Gxx1J7fGgnHQKytxsC3i9q0fHtxPcdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(38100700002)(508600001)(31696002)(86362001)(8676002)(6486002)(4326008)(7416002)(53546011)(8936002)(66946007)(83380400001)(186003)(316002)(5660300002)(66476007)(36756003)(2616005)(44832011)(66556008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NhQVdScWZxRXhBNi96eklIR3liZGhGN0o4MU5Ic3VjZ01MUmg4TTE5VG1z?=
 =?utf-8?B?eVZnSmh0RzhHZ25ST1FwZ0tyMEhYdHRaR3pqSlBQRkhpcWJMTGNVS043QS9k?=
 =?utf-8?B?K3V1M01PMzQyK1MwSVlhcytiekpYRlJ2ZnlmSDhEOVdwcytRLzZqT1phOHRr?=
 =?utf-8?B?YnVxcHlxd3dKcEtwRG5zQVg5dXljbTV0eVVpQy94a0pGc0pXN1ZnVjRYV040?=
 =?utf-8?B?b2NSaDZRSUZmamorSGtQQm1WMmpLamN5ekFId21Qbmp5R0g0eWhpMGhGdnZI?=
 =?utf-8?B?eHg3U054Q2FFbDFWS1lXWnhOU3JiMmJVTEg1c2g3c3FUTXlNbVpDOUlkQ0F1?=
 =?utf-8?B?MW96SExHbUk4QlRhYXJiMEQrWDJDak5JVWY1Y1FTci8zajhweFltTXZLbStY?=
 =?utf-8?B?NXBwTmNEK0JKUEo1eXQ5b24zVC9YWGRablYvNjVZSlJkM05nUGJzMjMvUldX?=
 =?utf-8?B?V29Ib2REeGF5UmlIMzNiY2Q0K2FuRG9WZXVpNXQ4ZTRaYWd5U1ZMNy9Yc2tI?=
 =?utf-8?B?Q3lHdjlKcmJ2U1RXM2hxbmtoMHNiN0hYMXIwd3ZGcnpIRVdSNXpQaGZhVm1x?=
 =?utf-8?B?K3IxSUgzcmJjMWRCU09UaUYzc0xLQjR1Zk5BRFRtTHgxS3dicWhyTi9zKzZs?=
 =?utf-8?B?d0YxSnNRWk1pNFk2YmgvQytSV1NNdFp4Z25RSDVLdFB2dnQ4N0NZSzc2Mjh2?=
 =?utf-8?B?WThJbmNSRmZnclQzRWk2YmZ1WkV5Sm96UW8wcWVEMXkyYlE1QzVWUVBiK1B2?=
 =?utf-8?B?MzRSREoyVDVBV0tsVnlaTFJWc1g0L1pRaVB3R0dLK0lCeVJHTDYzSUZlS0Zp?=
 =?utf-8?B?SWpHTjhkYy8xMVltK0JoSXlqdnBla0dxVmQraHdtcjU4bk5YSUFGQnNiZmVm?=
 =?utf-8?B?RFc3OURoYzFSaFArZkY3MUFLVUYxd3YyYVRiS1RLNFozdlo3SFd0emx4SElj?=
 =?utf-8?B?b0p5U1JSSENqUWNhUCtEdk9qYTk3cXVFdlNLZmFtWmQ0ckgwRS9pVmNqSEpF?=
 =?utf-8?B?S290UXhOeHBOT2lWYXBIRE1HNGtldmM2T2VpNjFYdmJheHRlSWJDTkJndWVa?=
 =?utf-8?B?WG1aSlVINVJXYjVicGVERDFENjIwcjEzSFluOWZpaCtSK0U3Tll5MFNlSk9o?=
 =?utf-8?B?c3NncTcvVHVXcDlWUlAralNpa0NIMGJqemFRYkRHRnVkSm5pTnFhNXFKZmxB?=
 =?utf-8?B?ZDB1clFxaG90KzgxKzNhT3BLamJTZE1NNktUSGlKc1NJbjBSMWpmMnRpSzhQ?=
 =?utf-8?B?RVd6NkpnakoxNU1pYUF5YmFtVnZXRFE5RHNCTXVDOExTckNyTk1FMi83b1lM?=
 =?utf-8?B?VXdlY2hzajZyM1JiYXo4TVN0eW9SSzJKcVBZQUpkN1pxNERrY1FVOFlCOHFX?=
 =?utf-8?B?anFoa2l1ZysyK3FpV2ZpUEZyWlU5YzlkMGEvenZGYWRQNzllZVhhVVpxeXJV?=
 =?utf-8?B?MCtyNmlPV1NSRUpKTTJvSjZ6d0NtUThORUo0d0VzYlN0YlRVYVNoZHp6Wko1?=
 =?utf-8?B?L2ZCVjJHRTc0N1VPMnlSRGpWRm9paUxpblRiZXcxNzVGVFdCc3pYTjhrUXQv?=
 =?utf-8?B?UXpzMlk3bGxqWVNjN2J3b2p2b2w3czBHQ09yWnh6eGhIVEwyZVNCWURQdFFX?=
 =?utf-8?B?MDBSZTUvOFZYTjdkazBwQ01sYkhGNSt1d3BlNlFOZVpVRy9CZVMvZVZ5SnFY?=
 =?utf-8?B?d2ErTE5peFFZZXZvSDNvajY2TWdBK3lXMjV4SFhaclpCU25LaUNPMXVKMU8y?=
 =?utf-8?B?L2JvZVlOY2hJRmM0ZjBIWTVlS3NKRGhSdFZSYytmU3VoV3VvTGswNkw3ckFZ?=
 =?utf-8?B?RHNwQVd6c1FOQjYvRkZqc1pKd25VT1BCMm5oL2o1LzdKbWoyRERGNlB1OER4?=
 =?utf-8?B?RmxHdk1TVzRNV0xnbFF0blpCejJzdkhnM00rMkNuclBvdG0xdUVaNDNWelU3?=
 =?utf-8?B?clZJVVRVL2UwWTRaeW9GQXVpQmNaYm8zamJkWmRZZUdFcDJRbUFaMGV5NmJQ?=
 =?utf-8?B?czh3dks4UVFmUUgxNVRwb2xyRG01YVVCZVpIdS90UEVFMGI1WmtOUHBUQmM5?=
 =?utf-8?B?elhRZWthaXg5eG9Jbkc2bTcwVEYzSGhLUTdPZkJLaWpFQ3F4SUdtZVJ0Wmty?=
 =?utf-8?B?L3l5ZFlWOTU5YllINmdzVWJpNmdXQUdjK2M4WDJpMjBMd29aNG90dHBLSERr?=
 =?utf-8?B?NjFJNEExZXhxd0ZKOHlYcnJ3R0NhRFZyY2xIa1FBaTVFZURKVHVWenhDSWty?=
 =?utf-8?B?VVozVzJ6cWtHcXJNZlJ3WUoxTXM2OHdPZ3JCR0FBdkNyUkZLTy9UUEQyOGpV?=
 =?utf-8?Q?AvMhykAXtuAoA1RYwk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1aeebe-58aa-479c-b2d0-08d9b67429dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 15:47:08.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy5POFUfnCAuxK95TqGAc7mhJ2IHolUUQCnAvWHI0YmoTKLlR96WanbCIAjaSl1+LrtdGxaFqCFRcJnxgHX3EGzUqhaRrXQD5dS0XDRKm60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3624
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030100
X-Proofpoint-ORIG-GUID: 6d-iUpvDyOvZQPsWFCy-BaaR1AAq2ihQ
X-Proofpoint-GUID: 6d-iUpvDyOvZQPsWFCy-BaaR1AAq2ihQ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/2/21 12:26, Robin Murphy wrote:
> On 2021-08-27 14:28, Ross Philipson wrote:
> [...]
>> +IOMMU Configuration
>> +-------------------
>> +
>> +When doing a Secure Launch, the IOMMU should always be enabled and
>> the drivers
>> +loaded. However, IOMMU passthrough mode should never be used. This
>> leaves the
>> +MLE completely exposed to DMA after the PMR's [2]_ are disabled.
>> First, IOMMU
>> +passthrough should be disabled by default in the build configuration::
>> +
>> +  "Device Drivers" -->
>> +      "IOMMU Hardware Support" -->
>> +          "IOMMU passthrough by default [ ]"
>> +
>> +This unset the Kconfig value CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> 
> Note that the config structure has now changed, and if set, passthrough
> is deselected by choosing a different default domain type.

Thanks for the heads up. We will have to modify this for how things
exist today.

> 
>> +In addition, passthrough must be disabled on the kernel command line
>> when doing
>> +a Secure Launch as follows::
>> +
>> +  iommu=nopt iommu.passthrough=0
> 
> This part is a bit silly - those options are literally aliases for the
> exact same thing, and furthermore if the config is already set as
> required then the sole effect either of them will have is to cause "(set
> by kernel command line)" to be printed. There is no value in explicitly
> overriding the default value with the default value - if anyone can
> append an additional "iommu.passthrough=1" (or "iommu=pt") to the end of
> the command line they'll still win.

I feel like when we worked on this, it was still important to set those
values. This could have been in an older kernel version. We will go back
and verify what you are saying here and adjust the documentation
accordingly.

As to anyone just adding values to the command line, that is why the
command line is part of the DRTM measurements.

Thank you,
Ross

> 
> Robin.

