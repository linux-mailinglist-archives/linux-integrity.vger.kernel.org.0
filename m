Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A524A487
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHSQ6x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 12:58:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgHSQ6w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 12:58:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JGaXb3015676;
        Wed, 19 Aug 2020 12:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jMJZ7hxr2h4fIhlHLvJKIz20BuWRg82uNHPYiWK7SmE=;
 b=pZ0OAVHgKl8bgM3bMXTW2VHCz8f+/qFZHqmWNyQIjW88tgSIppEkxQChetrdnxWUFKIm
 sJKFWoOIer+oUnnA7Ug3g+igRABD4f8ouxPVVXFarASVpUloyNFfzfRJ/U+sqZfVAz0/
 csm9T8/aXK6mVj14i+z7ItdhUjlHZFT9fmkZEZMY+zmgXEEJSjw+FiLPg5w1rVI1Eyuz
 4y5PCmN21B4gZYQ5+2Oz6ET8Zc1m1fmCeOt98TKdwr0TV808iNJnIC5UzNWkF9RyUnAD
 kRhCfRJbdu5JphXuyRtAAlMNkeUZvj/2g9TZ0I/Hh6TVsMQnztN//4SnI/US5bK3nJjO 9A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3317aa9a19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 12:57:48 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JGsw4c021766;
        Wed, 19 Aug 2020 16:57:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3304buha58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 16:57:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JGvi7P28443036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 16:57:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F68AE04D;
        Wed, 19 Aug 2020 16:57:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19468AE053;
        Wed, 19 Aug 2020 16:57:43 +0000 (GMT)
Received: from sig-9-65-250-194.ibm.com (unknown [9.65.250.194])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 16:57:42 +0000 (GMT)
Message-ID: <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Aug 2020 12:57:42 -0400
In-Reply-To: <20200819161845.GK1152540@nvidia.com>
References: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
         <1597850231.3875.13.camel@HansenPartnership.com>
         <20200819161845.GK1152540@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_09:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=3 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 13:18 -0300, Jason Gunthorpe wrote:
> Yes - it was dropped because TPM 2 was a *complete ABI break* for
> everything. The kernel was reset to a uABI that matches current
> uABI standards starting TPM 2.
> 
> The whole userspace needed to be redone anyhow, and certainly nobody
> objected at the time.
> 
> At least my expecation was that a sensible userspace for TPM (for
> administrator user) would be built, like we see in other subsystems eg
> 'ip' for netdev.

"Because TPM 2 was a complete ABI break for everything" could be reason
for upstreaming a minimal subset of functionality initially, which
could be expanded over time.  I don't recall a discussion about limting
features in the future.

Mimi

