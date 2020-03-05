Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9117AFEA
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 21:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCEUq1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 15:46:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgCEUq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 15:46:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025KcnB5076512;
        Thu, 5 Mar 2020 15:46:17 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvbk8nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 15:46:17 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 025KdjSp079121;
        Thu, 5 Mar 2020 15:46:16 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvbk8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 15:46:16 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025KeMiE009438;
        Thu, 5 Mar 2020 20:46:15 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2yffk7hk2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 20:46:15 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 025KkEKD62456182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 20:46:14 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09A7DC6057;
        Thu,  5 Mar 2020 20:46:14 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F29AEC6055;
        Thu,  5 Mar 2020 20:46:11 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.217.149])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 20:46:11 +0000 (GMT)
Message-ID: <1583441170.3927.37.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
From:   James Bottomley <jejb@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Mar 2020 12:46:10 -0800
In-Reply-To: <alpine.DEB.2.21.2003052132540.5431@felia>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com>
         <9127f0318e8507ca0b4e146d9b99d9ecb27f7f28.camel@linux.intel.com>
         <alpine.DEB.2.21.2003052132540.5431@felia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_07:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-03-05 at 21:34 +0100, Lukas Bulwahn wrote:
> 
> On Thu, 5 Mar 2020, Jarkko Sakkinen wrote:
> 
> > On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> > > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys
> > > subsystem")
> > > renamed trusted.h to trusted_tpm.h in include/keys/, and moved
> > > trusted.c
> > > to trusted-keys/trusted_tpm1.c in security/keys/.
> > > 
> > > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > > 
> > >   warning: no file matches F: security/keys/trusted.c
> > >   warning: no file matches F: include/keys/trusted.h
> > > 
> > > Rectify the KEYS-TRUSTED entry in MAINTAINERS now.
> > > 
> > > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > > Sumit, please ack.
> > > Jarkko, please pick this patch.
> > 
> > I'll pick it when it is done. I acknowledge the regression but I
> > see no reason for rushing as this does not break any systems in
> > the wild.
> > 
> 
> Agree. No need to rush this. I sent out a v3, and I hope to get
> Sumit's ACK and then you can pick it for the next merge window.

From a process point of view, I don't quite understand this.  You're
altering an entry in the MAINTAINERS file which belongs to the three
maintainers of trusted keys, you only need our ack to do that, which
picking up via the trusted key tree will substitute for.  It would be
useful to have Sumit review this because he moved the files and there
may be something we missed, but a reviewed-by: is a nice to have and
not a block on the process.

James

