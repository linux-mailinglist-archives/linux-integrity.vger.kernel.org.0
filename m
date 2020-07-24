Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3422CA26
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGXQHK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 12:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbgGXQHJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 12:07:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OFXnMJ103421;
        Fri, 24 Jul 2020 12:07:01 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32facf600k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 12:07:00 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OG5CHL007680;
        Fri, 24 Jul 2020 16:06:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 32brq844a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 16:06:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06OG6t7B32702912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 16:06:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D90F0A405C;
        Fri, 24 Jul 2020 16:06:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00558A4068;
        Fri, 24 Jul 2020 16:06:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.187])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 16:06:54 +0000 (GMT)
Message-ID: <1595606814.5211.251.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Date:   Fri, 24 Jul 2020 12:06:54 -0400
In-Reply-To: <20200724131845.GB24626@dell5510>
References: <20200724070038.29491-1-pvorel@suse.cz>
         <20200724070038.29491-2-pvorel@suse.cz>
         <1595592111.5211.246.camel@linux.ibm.com> <20200724131845.GB24626@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_05:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-24 at 15:18 +0200, Petr Vorel wrote:

> 
> > Other than the policy "action" - measure/dont_measure,
> > audit/dont_audit, appraise/dont_appraise - being the first keyword,
> > the ordering of the policy options and flags is flexible.  Most
> > policies do provide the "func" option immediately following the
> > "action".  This would normally work.
> OK, is this correct?
> if ! grep '^measure.*func=KEXEC_CMDLINE' $IMA_POLICY >/dev/null; then

Yes, that works.

> 
> @Mimi, @Lachlan: if you both ack my changes, I can fix the code before merging.

That's fine. Feel free to add my Reviewed-by.

Mimi

> If there are more changes needed and thus Lachlan plan new version, please use
> my patches from https://patchwork.ozlabs.org/project/ltp/list/?series=191990&state=*
> (download https://patchwork.ozlabs.org/series/191990/mbox/ and import it with "git am")
> or clone my github fork and use kexec.v3.fixes branch:
> https://github.com/pevik/ltp/tree/ima/kexec.v3.fixes).

