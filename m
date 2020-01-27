Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D993214A961
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgA0SBq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 13:01:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0SBp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 13:01:45 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RHtheZ119214
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 13:01:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrgqe1d4m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 13:01:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 18:01:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 18:01:41 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RI1eMN51314770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 18:01:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12F6E11C052;
        Mon, 27 Jan 2020 18:01:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 431D411C04A;
        Mon, 27 Jan 2020 18:01:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 18:01:39 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Jan 2020 13:01:38 -0500
In-Reply-To: <87e6b531-3596-4523-a6b0-629ae8fd6995@linux.microsoft.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
         <87e6b531-3596-4523-a6b0-629ae8fd6995@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012718-0020-0000-0000-000003A4778E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012718-0021-0000-0000-000021FC1E62
Message-Id: <1580148098.5088.32.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_06:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-27 at 08:50 -0800, Lakshmi Ramasubramanian wrote:
> On 1/27/2020 8:01 AM, Mimi Zohar wrote:
> 
> > +
> > +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> > +		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
> > +			break;
> > +	}
> > +
> > +	if (i == ima_tpm_chip->nr_allocated_banks)
> > +		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
> > +
> 
> Can the number of allocated banks (ima_tpm_chip->nr_allocated_banks) be 
> zero? Should that be checked before accessing "allocated_banks"?

Yes, that might be the true, but I think the solution is not fixing
the problem here, but when ima_tpm_chip is set in ima_init().
tpm_default_chip() should be modified to return a TPM with at least
one bank enabled; and ima_init() needs to go into TPM-bypass mode if
there isn't.

Can anyone look into this please?

Mimi

