Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA01047F6
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 02:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKUBWR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 20:22:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbfKUBWR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 20:22:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL1KgoF024174
        for <linux-integrity@vger.kernel.org>; Wed, 20 Nov 2019 20:22:16 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf5rd3fx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Nov 2019 20:22:15 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 21 Nov 2019 01:22:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Nov 2019 01:22:12 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAL1MBbS54525976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 01:22:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517D1A405B;
        Thu, 21 Nov 2019 01:22:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 992A9A4054;
        Thu, 21 Nov 2019 01:22:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.233.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Nov 2019 01:22:10 +0000 (GMT)
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 20 Nov 2019 20:22:10 -0500
In-Reply-To: <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
         <20191118223818.3353-3-nramas@linux.microsoft.com>
         <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
         <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112101-0028-0000-0000-000003BD4EE4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112101-0029-0000-0000-0000248074E8
Message-Id: <1574299330.4793.158.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210008
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-20 at 15:40 -0800, Lakshmi Ramasubramanian wrote:
> On 11/20/2019 3:28 PM, Eric Snowberg wrote:
> Hi Eric,
> 
> > 
> > I’m interested in using this patch series, however I get the following on every boot:
> 
> > [    1.222749] Call Trace:
> > [    1.223344]  ? crypto_destroy_tfm+0x5f/0xb0
> > [    1.224315]  ima_get_action+0x2c/0x30
> > [    1.225148]  process_buffer_measurement+0x1da/0x230
> > [    1.226306]  ima_post_key_create_or_update+0x3b/0x40
> 
> This is happening because IMA is not yet initialized when the IMA hook 
> is called.
> 
> I had the following check in process_buffer_measurement() as part of my 
> patch, but removed it since it is being upstreamed separately (by Mimi)
> 
>   if (!ima_policy_flag)
>   	return;

Did you post it as a separate patch?  I can't seem to find it.

Mimi

> 
> Until this change is in, please add the above line locally on entry to 
> process_buffer_measurement() to get around the issue.
> 
> thanks,
>   -lakshmi

