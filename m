Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696D22DE290
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Dec 2020 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLRMMr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Dec 2020 07:12:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgLRMMq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 07:12:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BIC3QYC096885;
        Fri, 18 Dec 2020 07:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1WhVLQxqpRhmeodQp0Sj97c2pCEt49I/2l6ZG0X9nVM=;
 b=i95/hY6/gn7MGgA6A7Z7SCzNpE1spiWvkJzl5a+FUyZWFHMYkOUz8eRzcRtKpSRgPiva
 fTQIGZTGJQUarjCUXt/fwNinMJCxIhFXagr8RW+RibJL7sKuUaEeMpi919NhqAAibHaq
 nclQyJWvdR2e63JhR7Y5rW/Ir8Z6oVk7j4pHcbve1AajXGibXkZ1sSG3uwsKEDHo/LPx
 Be+8dV4/cQ/p60BfaeTALWT/CeETAg7ByiVGR82z2b/wX3SqhsHdwiuGGF1y7fGNPSl0
 RUircIIHk9c/E7ZcR6Y0I5Qcq36jnYcInjPsZwmyBo+lR+CwbsSkdg1lVj/u+upexpMU qg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35guj7h967-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 07:11:59 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BICAEOk016869;
        Fri, 18 Dec 2020 12:11:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8hd30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 12:11:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BICAeSP46924164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 12:10:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F3CEAE051;
        Fri, 18 Dec 2020 12:10:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC59AE056;
        Fri, 18 Dec 2020 12:10:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.48.118])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Dec 2020 12:10:38 +0000 (GMT)
Message-ID: <aa87efd5d1b3290347af8ada73deab6b5e2beb3b.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/4] IMA: Move get_algorithm_digest(),
 set_digest_index() to ima_setup.sh
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 18 Dec 2020 07:10:37 -0500
In-Reply-To: <X9ySNMlhYIMKd+SY@pevik>
References: <20201214221946.6340-1-pvorel@suse.cz>
         <20201214221946.6340-2-pvorel@suse.cz>
         <aed2e8ee7b05772a8cc2988ae275282bec7ef504.camel@linux.ibm.com>
         <X9ySNMlhYIMKd+SY@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_06:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Fri, 2020-12-18 at 12:27 +0100, Petr Vorel wrote:
> > On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> > > To be reusable by more tests (preparation for next commit).
> 
> > > Call set_digest_index() inside get_algorithm_digest() if needed
> > > instead of expecting get_algorithm_digest() caller to call
> > > set_digest_index() before.
> 
> > For the existing builtin templates, the algorithm/digest field is
> > consistent.  With support for per policy rule template formats, there
> > isn't necessarily a single template format for the entire list.
> 
> > In the future "set_digest_index" might need to be renamed to
> > "get_digest_index" and the lookup done for each line.
> Thanks for info, noted as TODO. Policy example would speedup fixing.

The simplest way of forcing this to happen would be by specifying a
custom format on the boot command line ("ima_template_fmt=") and
measuring buffer data (ima-buf), like the kexec boot command line.

measure func=KEXEC_CMDLINE template=ima-buf

where "template=ima-buf" isn't needed on kernels with commit
dea87d0889dd ("ima: select ima-buf template for buffer measurement") .

thanks,

Mimi

