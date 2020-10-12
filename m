Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C1028BF3C
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Oct 2020 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbgJLRve (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 13:51:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389562AbgJLRvd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 13:51:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CHV0le096101;
        Mon, 12 Oct 2020 13:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dnPHlw+SixLjPSOZAiUrHZmthvdDEw5HoO6Is7k2hMs=;
 b=MbsOPyGhAzqqUc5MJgSZL6J360vhWP5fGgsQbDXnzZMJxU8ddFzWPzEPhllq/s+K+urj
 2fGLPdkNeuoCMMtlBUk06N3GzyhdG7IfR8jWnUWo/Wv8q08RipFhnF2rp1WnXD0wJW4s
 zeGrlPR67argHVXE/bY5YPz46D0YeueztYeT6eMHcArlOr+StVr3ro8AyCXdAFkOKx4X
 TUKptLDxgPoVm9HpW4nnWEXQSAZQUiB20+nFeJBBGd6bnZQ8GJHY/sYtwlyCft/k2Ao1
 QGxmNP4eqmIDP62w/kvpMtG1pzD210520XMe3u1leOC6Y/jZ0ahT1i4gj3KCzqqsEwhP Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 344udbgxj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 13:51:19 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09CHV5Uo096899;
        Mon, 12 Oct 2020 13:51:18 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 344udbgxhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 13:51:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CHlVmn018816;
        Mon, 12 Oct 2020 17:51:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 34347h15q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 17:51:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CHpEcV23200054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 17:51:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6760052052;
        Mon, 12 Oct 2020 17:51:14 +0000 (GMT)
Received: from sig-9-65-230-9.ibm.com (unknown [9.65.230.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 061D75204E;
        Mon, 12 Oct 2020 17:51:11 +0000 (GMT)
Message-ID: <a9a35d8b480112fe40b45392d0f0e9dcb5be536e.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix sizeof mismatches
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Joe Perches <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 13:51:11 -0400
In-Reply-To: <55ae0b6152c84013d483b1bbecb28a425801c408.camel@perches.com>
References: <20201007110243.19033-1-colin.king@canonical.com>
         <55ae0b6152c84013d483b1bbecb28a425801c408.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_14:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 impostorscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120131
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-07 at 11:27 -0700, Joe Perches wrote:
> On Wed, 2020-10-07 at 12:02 +0100, Colin King wrote:
> > An incorrect sizeof is being used, sizeof(*fields) is not correct,
> > it should be sizeof(**fields). This is not causing a problem since
> > the size of these is the same. Fix this in the kmalloc_array and
> > memcpy calls.
> []
> > diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> []
> > @@ -216,11 +216,11 @@ int template_desc_init_fields(const char *template_fmt,
> >  	}
> >  
> >  	if (fields && num_fields) {
> > -		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
> > +		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
> >  		if (*fields == NULL)
> >  			return -ENOMEM;
> >  
> > -		memcpy(*fields, found_fields, i * sizeof(*fields));
> > +		memcpy(*fields, found_fields, i * sizeof(**fields));
> 
> Maybe use kmemdup instead.
> 
> 	if (fields && num_fields) {
> 		*fields = kmemdup(found_fields, i * sizeof(**fields), GFP_KERNEL);
> 		etc...
> 

Thanks, Joe.  Since this patch will be backported, perhaps it would be
better to leave this as a bug fix and upstream other changes
independently.

Mimi

