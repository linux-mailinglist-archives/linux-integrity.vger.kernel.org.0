Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F7222536
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGPOXW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 10:23:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbgGPOXW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 10:23:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GE5bCl029114;
        Thu, 16 Jul 2020 10:23:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329uejmxaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 10:23:09 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GE8SBE039225;
        Thu, 16 Jul 2020 10:23:08 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329uejmx8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 10:23:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GEFwkI008327;
        Thu, 16 Jul 2020 14:23:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 327527jw4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 14:23:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GEN3Nm53215382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 14:23:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E68414C064;
        Thu, 16 Jul 2020 14:23:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE8B34C046;
        Thu, 16 Jul 2020 14:23:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.202.131])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 14:23:01 +0000 (GMT)
Message-ID: <1594909381.12900.361.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Rename internal audit rule functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-audit@redhat.com
Date:   Thu, 16 Jul 2020 10:23:01 -0400
In-Reply-To: <20200710194234.GA7254@sequoia>
References: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
         <1593466203.5085.62.camel@linux.ibm.com> <20200710194234.GA7254@sequoia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_06:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 suspectscore=2 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160105
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-10 at 14:42 -0500, Tyler Hicks wrote:
> On 2020-06-29 17:30:03, Mimi Zohar wrote:
> > [Cc'ing the audit mailing list]
> > 
> > On Mon, 2020-06-29 at 10:30 -0500, Tyler Hicks wrote:
> > > 
> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > > index ff2bf57ff0c7..5d62ee8319f4 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -419,24 +419,24 @@ static inline void ima_free_modsig(struct modsig *modsig)
> > >  /* LSM based policy rules require audit */
> > >  #ifdef CONFIG_IMA_LSM_RULES
> > >  
> > > -#define security_filter_rule_init security_audit_rule_init
> > > -#define security_filter_rule_free security_audit_rule_free
> > > -#define security_filter_rule_match security_audit_rule_match
> > > +#define ima_audit_rule_init security_audit_rule_init
> > > +#define ima_audit_rule_free security_audit_rule_free
> > > +#define ima_audit_rule_match security_audit_rule_match
> > 
> > Instead of defining an entirely new method of identifying files, IMA
> > piggybacks on top of the existing audit rule syntax.  IMA policy rules
> > "filter" based on this information.
> > 
> > IMA already audits security/integrity related events.  Using the word
> > "audit" here will make things even more confusing than they currently
> > are.  Renaming these functions as ima_audit_rule_XXX provides no
> > benefit.  At that point, IMA might as well call the
> > security_audit_rule prefixed function names directly.  As a quick fix,
> > rename them as "ima_filter_rule".
> > 
> > The correct solution would probably be to rename these prefixed
> > "security_audit_rule" functions as "security_filter_rule", so that
> > both the audit subsystem and IMA could use them.
> 
> There doesn't seem to be any interest, from the audit side, in re-using
> these. I don't quite understand why they would want to use them since
> they're just simple wrappers around the security_audit_rule_*()
> functions.

The security_filter_rule_* wasn't meant to be in addition, but as a
replacement for security_audit_rule_*
> 
> I'll go the "quick fix" route of renaming them as ima_filter_rule_*().

That's fine.

Mimi
