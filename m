Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D1467CD0
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 18:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382438AbhLCRxE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 12:53:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36658 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343541AbhLCRxD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 12:53:03 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3H7N9i002175;
        Fri, 3 Dec 2021 17:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KGJoHFN6t30Hg/u4/UO/V5+fT7CS/VPCuSPZDVXXVdM=;
 b=UfHoAOedJyIhaA7AtruxaKMbtyKpWenSmY/RVh9MD1PZI/VUw4jyktS93aB1Qe32dlvc
 ou+yCAaJLfH7V2tbkvm02kWb6R0e2AINmPCDP4WHKkEd9hPjHKzY9pcfK2/NyzY2tfwA
 kwLBQRwFT993sZCUMta/jRW92tWI4eT/h46J+6jW14UBBVrT/epiXOxUgKflTBNOhaqk
 qJPoRDSBpLW1qv/Gog2BvvgifMuJHCIma96Ni63E4PD04AqEwqB+yUBMUe6n06I2/3sH
 tHuOdSpWQPbLjPWBIuB3+zfKgkgyc08UlaD9pOZ1PtM3ZDDrIjIkSEvhiSW5EhcjEtNE XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqkx5hrnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 17:49:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3HexrX007725;
        Fri, 3 Dec 2021 17:48:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3ck9t6jxf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 17:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSaohaEiPxdI6AoczlDynC6fxd14KODCpMJa/xD81/u0sLun2RhRxTTy8LZM928kF48Yz4tYNGryOL3q5wyPiUBAqjD4G7p9s5Vk6GzpbE6I4yoO7MqMvt9v9MfkHii1W3PWlSdOYlbRxNYJr4xZj9rzhf7wqPURBClvpbCxiIBOknSwtYaWeG9fNx72zQ/3hqMAEb5Y+Lkj3nREpuMAf7+iJiwCohb4sSLEMTqQZUkvlSxhRDcX1Xhfgq0nb0RMq0p2gTlC4ozk/JMO5d4btZVLdbKBvsgVk1mRG6gj5Ehmst5woIj2mBy1TU55wcIoBi+D/+v1T/Cb44Ie4ByA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGJoHFN6t30Hg/u4/UO/V5+fT7CS/VPCuSPZDVXXVdM=;
 b=g+XWqQs4pAbey+3dk8S8c5KuOMQdZ7LzL5M6pyLKxFJStXAHA1LT2YP+CZAvqzHj4rY4UtkZfFZbi/nMHjG73ThtsTTDo6e5vdbTOkYWurtDrmrjJc7ZOlOnYikEJIRHMlAZmIljPXjiTFjCAzcW8d6Wj3Q3/7ujWYVZSSEx7agaA90f/+q6f0zQnT90qbFDDH2pa22E1UX6I10S4ZmbjBZwTRwNH/4SFEO9KHlMbSZDFKWBBa1Z446Q6Uo1WGDeWbCoV6W+48mR80eWF/1EEaTqy3NqBKvCLX88R2R2NOWEtYjsnQjAiX9VbmRrRepg6O4MkgjWOUA/N0lRTgSbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGJoHFN6t30Hg/u4/UO/V5+fT7CS/VPCuSPZDVXXVdM=;
 b=Ns+jPxBP+DEsuLnWZNnGSuPTVMQf0OUk4sbgR6UwnTtY2kPpD0qDlWuev3TsU/LbYxUsKcgX2KNGrxYMwnJZHE833IsXX2dE/pvvdAyq3jT6D1CYc6J8wZirsRCtlHl+3R+Lavr5neuGdGPWPTIIb9lylisW4DvzDSjVfLGR91k=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4002.namprd10.prod.outlook.com (2603:10b6:a03:1b0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 17:48:46 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::b46e:493b:14b7:9c83]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::b46e:493b:14b7:9c83%3]) with mapi id 15.20.4755.019; Fri, 3 Dec 2021
 17:48:46 +0000
Message-ID: <b2fd060d-0ac8-b00e-cebb-46015dfea14c@oracle.com>
Date:   Fri, 3 Dec 2021 12:48:43 -0500
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
 <6713b6b2-3c6d-8318-ee9e-e1746f02a3a5@oracle.com>
 <7ee55288-209f-8f19-ef69-27e2a5448473@arm.com>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <7ee55288-209f-8f19-ef69-27e2a5448473@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
Received: from [IPV6:2601:191:8500:cff0::7928] (2601:191:8500:cff0::7928) by BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 17:48:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6149e2-f5ed-43bc-09ce-08d9b68527bc
X-MS-TrafficTypeDiagnostic: BY5PR10MB4002:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4002A0F077B704765CAC5D85E66A9@BY5PR10MB4002.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNoMfgdubtWHYNDz0LZHViSkjqOPWHo6xf8eibYFW4OjYaIvudYVquFz7Z1EV3ij8mLomV/VrY6oN8LMrMJ/J9FfGQM8cUKKLk9x44RkPKlf97dRWh3I72RhuUlv3rKImWhPiCw7WLfgIQC8zwDamWMeUCjTmP+C3WKKljwhjdHPTeQ6EYGNPdQodyAU1PH70stB9ozqPkYuJ22YDeiNdFW9VDPGVuqPcoGT23dNwOKu3UxhTwCOho1hmM6yOAjcwSIoyPVJoBcR6lI8pppcgES66S6yM16StcdB2hyXAyzv4qHTREz++nr34WivebItioaPcvW0+vHrN6ZrzaYxSSx99oGhXWkguxOK7WxWxdeWu5yC0JnzpSOH+9zp3WnH7ABC31/mI5oEveBXQMvlF5y/kzGzDyqC4B6yNYJHtMwoxgwybQpCUGtq4J8+791eyRCvSvG+TR7H5WT/cF8RDLSWNYWSB2OUsHFX7Ne7ncVSKkdtWHX2lzi4Z+bcdbRBXKIECjOTJWgsrycnQYPBetyxtIXPtNay9G9mmNwMjO2vCKuYzakxUUSY8cXPoL06NUlVXcJVYfeVu4Qm5ZHCAjciNdFh2dtdW/sDDsRD/IDYIRbNhrE+LnxW/CqhdWtOJBR2QfEDalx9IKqAmtFDfnjipziVoBRB1nby8STW8xx347gdGHCHphKu6l9AWSWFXFgzaQbTndEBnqo3iTFyeC41R6+5E1wR9h6+KEegnCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2906002)(31696002)(66946007)(31686004)(7416002)(66556008)(5660300002)(8676002)(316002)(83380400001)(36756003)(8936002)(6486002)(508600001)(38100700002)(53546011)(2616005)(4326008)(44832011)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05MQXVDUTlGdDZzNzRwZnlNSHo1elZjcDhQaWFHUUV1Z3lXYjlrU1hUTlRF?=
 =?utf-8?B?VHRqK3B2SDBMMkRMdXVLWXgxOXliZHBab1FqUzlEeVF4MlhFYk9lbVMxYXo5?=
 =?utf-8?B?S0RhVnhVNHhRMXhNL1BuZVZRTEs3cTVhUTd2QnAvTTJtYzRCRGtZYlVXRjdh?=
 =?utf-8?B?UkR1UTdQUU1PRzE2ZTdaUkxTWmFFdUp2ZlNub2ltUVJjSVA0VDJ2dE5Vd3V6?=
 =?utf-8?B?U1lnN1gzSjgzcFBQWWlTTUdsdkFVZzZlMmhsWk1RbjZRV0lPalByc2xYZHUx?=
 =?utf-8?B?TkpTWHAvTWVaMXlNWk1lYzdTSHhqRTE5SS9QVDU3S3BNVS9kZVZJWUxCSlcx?=
 =?utf-8?B?YXhkNU5jaXJwTlI5QjJ4UjVmZFNUYWx1bWdwS0VOcWtZUlIvOXo5OXZoU3ls?=
 =?utf-8?B?c2t2MTNXNmc5ZEFYL2xsUENzSUVqUllDQmRnbTEzWURybG9EaW03WnV3bHBJ?=
 =?utf-8?B?ZVVXNGloSDQzaTVpUUUyRVJ4TEMwc3RSVDRQVWFuOUwwZE5zblY0Vit6WjAx?=
 =?utf-8?B?VWtsSTZwQ3J2QVVreXNMRGV4dEpxNlJ1Q2ZqazZQTnRuSVhVeEZ5NXozTXJP?=
 =?utf-8?B?SjZSYXM5MCtwc2pGYkFHZ2ZvNVdGR1B5Z0ZNYm9pTHBoRTNQb3Q2c3FNN3lk?=
 =?utf-8?B?djUzTVE5Q3oyVWE4S0FabFk1VzRVYjRrYzVMVXVna2hDZEZRMm15MXVuVWJY?=
 =?utf-8?B?MDlCNGNsK2NaR2JuVXRueEVnNGlVOXZ4bm56dlpsTUFwYWhRMUpnd1NJM0Yv?=
 =?utf-8?B?eVp4MWJwNVkrZnlFL0t6UlJoYUszZWFsYW51ekRRb3dUV2ZmalFKSi9nNEpI?=
 =?utf-8?B?TWd0NUQ2NkZtTHJjVGpQWUorcGtiTVdoWHZzQjUwTTZTREE2OVRRZmRaa0or?=
 =?utf-8?B?dHJwRDRCRzVQVERhNkZoZVBDOVZJRjE0MkV5NmtqZ0JJeklzQW8xYXpTaDhu?=
 =?utf-8?B?NFFaM1NEOVkwdmRtNTJWZ3R3Q1F1VVZqMFZPWHlFSXB0WkU4MElMd2V3Y05J?=
 =?utf-8?B?VW8vWXhvNW5vZWd4aXR3SjJSUG9rclUraXFFTGZ5Q3dmVVM1S1gzR1Z6djhU?=
 =?utf-8?B?VnNPNzdjVDNCTWp1bzdNdm92VHlhdzVpdmoyME04VktSS1JpUXZYd3ZTK3lG?=
 =?utf-8?B?Wjl6VVVBU1NLK3BuQXBGcXYzRkltVVpCN0ZENTFtQ2RmSGxyKzVSMW5MeDh2?=
 =?utf-8?B?SnlaOGphZ0xaTEgrWTlpalNiRXlmQkI0Z1BvdlV0VURZT3VjeFA4RHdHR25z?=
 =?utf-8?B?UFFIK0tEckZmN1V6YTZTRXM2ckJuK1llMlpLSmtlajgzaU1NQVdwTlFNUGs4?=
 =?utf-8?B?ZXZLWVNVaTZsZStldzhoaXp1SVRMSzh5TkxsaVhLOEY5ZzBFSDkvSFp4Zlgy?=
 =?utf-8?B?a1ZjMXRFSURJNHRnUWI5eUFEMUVPSUNMd2Z4ajVwR1dMNTI2QlpxR2FwVnRp?=
 =?utf-8?B?cUtOdFZ0WENYTmMyOTdLRTNsSjZTRFJQTndnVnZUK2w4L01sOVpTTU9tTHNj?=
 =?utf-8?B?Mks0VFhUaHlzUkkwc3FUMnM0aFp6YkFDWnNBNUFhekRJWFY2a2VtZ3VkRTI4?=
 =?utf-8?B?Q3BkMzhrVkxCUzZaRVdKZUtnVytOaHQ4Q0lIV3UvQi9La2JxZTM5M1p2dmhj?=
 =?utf-8?B?Y1AwM2pNNUh4dm1ZK2FtWmZRVVNNdHhtUHNRK3hVMjVTOXNqT0gvWURIL1VB?=
 =?utf-8?B?Nmlwakt4QjZLYThKUGZWSFZsVG5ZMVZjdVN1SWdWdXR2R3d2SWV1VzVIV2dR?=
 =?utf-8?B?QndiMFE1akx0aFlQQU9rdjZYd0ZWc25xa0wxelpoK0g1RTdCUEQxU0ZhVXh3?=
 =?utf-8?B?NHNaQXg3ZGhUTnEzdXZKRzl2T0p4RmpMZmptRWVwR0N1WnRkdXgvNjVSOFVs?=
 =?utf-8?B?SXBTKzExWlFmdjJ0L003ODlPYjh6cTBmMTRLdE5xWE5JM09xb0piZ0hYcVRv?=
 =?utf-8?B?TXY2OVYvYTRVME1rNElFeUt4ekkvNU0raC9RSVpDMXp3dEJ4QXdBODFSaE4z?=
 =?utf-8?B?NXpXZU1WQ1ZvYnFDaEJ3UEUrRFE5MW92OUlvMUh4UlNBZEpwOUZ6U1NqQXBT?=
 =?utf-8?B?RnNsV09wMnFuSS84TGtMRjJuVnVqK0VJUzd1RU5GUkNaOTBzcWtSRCtkWGNQ?=
 =?utf-8?B?alVIVThpV1NHejZRdmZTWDBuenMxQWFNOUFmYk96MkhVWWw0c3BoWmk2R1ZV?=
 =?utf-8?B?UFdJUkIzd2hCdnBUMEFhdDlVdUhyOFl0bWs0ZU1QUDVGSGRvL1UyTFUzMkxY?=
 =?utf-8?B?MVdIL1kwZ2V2dEE1SmxxbUY5UzFCK0lhb2tyR2c2cCs2cllFd2lSMzlPS0I0?=
 =?utf-8?Q?AgNus9vHSncl9gmF3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6149e2-f5ed-43bc-09ce-08d9b68527bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 17:48:46.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTZA3CU1DnQYApB/itWIfO7Iuc4UL3zWdNqxzOF8JvJeTIIeac3/ekZTD6lUjJsXj3jLlgX4H7rZxWNXQj9G7Yk5qoqX6jrba0VjRQ/oMI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4002
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10187 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030112
X-Proofpoint-GUID: ItEI_sDqqDNcbOXK0kLpEm5U1Gan_8t1
X-Proofpoint-ORIG-GUID: ItEI_sDqqDNcbOXK0kLpEm5U1Gan_8t1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/3/21 11:03, Robin Murphy wrote:
> On 2021-12-03 15:47, Ross Philipson wrote:
>> On 12/2/21 12:26, Robin Murphy wrote:
>>> On 2021-08-27 14:28, Ross Philipson wrote:
>>> [...]
>>>> +IOMMU Configuration
>>>> +-------------------
>>>> +
>>>> +When doing a Secure Launch, the IOMMU should always be enabled and
>>>> the drivers
>>>> +loaded. However, IOMMU passthrough mode should never be used. This
>>>> leaves the
>>>> +MLE completely exposed to DMA after the PMR's [2]_ are disabled.
>>>> First, IOMMU
>>>> +passthrough should be disabled by default in the build configuration::
>>>> +
>>>> +  "Device Drivers" -->
>>>> +      "IOMMU Hardware Support" -->
>>>> +          "IOMMU passthrough by default [ ]"
>>>> +
>>>> +This unset the Kconfig value CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>>>
>>> Note that the config structure has now changed, and if set, passthrough
>>> is deselected by choosing a different default domain type.
>>
>> Thanks for the heads up. We will have to modify this for how things
>> exist today.
>>
>>>
>>>> +In addition, passthrough must be disabled on the kernel command line
>>>> when doing
>>>> +a Secure Launch as follows::
>>>> +
>>>> +  iommu=nopt iommu.passthrough=0
>>>
>>> This part is a bit silly - those options are literally aliases for the
>>> exact same thing, and furthermore if the config is already set as
>>> required then the sole effect either of them will have is to cause "(set
>>> by kernel command line)" to be printed. There is no value in explicitly
>>> overriding the default value with the default value - if anyone can
>>> append an additional "iommu.passthrough=1" (or "iommu=pt") to the end of
>>> the command line they'll still win.
>>
>> I feel like when we worked on this, it was still important to set those
>> values. This could have been in an older kernel version. We will go back
>> and verify what you are saying here and adjust the documentation
>> accordingly.
>>
>> As to anyone just adding values to the command line, that is why the
>> command line is part of the DRTM measurements.
> 
> Yeah, I had a vague memory that that was the case - basically if you can
> trust the command line as much as the config then it's definitely
> redundant to pass an option for this (see iommu_subsys_init() - it's now
> all plumbed through iommu_def_domain_type), and if you can't then
> passing them is futile anyway.

Thanks you for your feedback.

Ross

> 
> Cheers,
> Robin.

