Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35A4CA156
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfJCPtb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 11:49:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727302AbfJCPtb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 11:49:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x93FgvC4055309
        for <linux-integrity@vger.kernel.org>; Thu, 3 Oct 2019 11:49:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vdj9c4hf7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 Oct 2019 11:49:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 3 Oct 2019 16:49:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Oct 2019 16:49:21 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x93FnKvn51642426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Oct 2019 15:49:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBA75204F;
        Thu,  3 Oct 2019 15:49:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.155])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 435D852050;
        Thu,  3 Oct 2019 15:49:20 +0000 (GMT)
Subject: Re: ima_tpm_chip is queried and saved only at IMA init, but never
 later
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 03 Oct 2019 11:49:19 -0400
In-Reply-To: <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
References: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
         <1569364624.5364.23.camel@HansenPartnership.com>
         <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100315-0016-0000-0000-000002B3BA9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100315-0017-0000-0000-00003314C5C4
Message-Id: <1570117759.5046.4.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=666 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 08:40 -0700, Lakshmi Ramasubramanian wrote:
> On 9/24/19 3:37 PM, James Bottomley wrote:
> > On Tue, 2019-09-24 at 15:31 -0700, Lakshmi Ramasubramanian wrote:
> > 
> > There has been some discussion that we could, for UEFI systems, use the
> > UEFI runtime drivers for the TPM until the actual driver is inserted
> > but no-one's looked into doing that.
> > 
> > James
> 
> Can IMA take a dependency on TPM and postpone IMA initialization until a 
> TPM device shows up?

IMA is already on the late_initcall(), waiting for the TPM
initialization to complete.  How would you define a TPM dependency?

Mimi

> 
> Has anyone looked into this?
> 
> Thanks,
>   -lakshmi
> 
> 

