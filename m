Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7668028D204
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgJMQRy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 12:17:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726482AbgJMQRy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 12:17:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DG1SC0061226;
        Tue, 13 Oct 2020 12:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C2q7PKdbI52/5iDNfG88xYlgTuLh1WRiTVN3OaCUuxY=;
 b=fCpVqlvOFdMnLJwYFJ/QygRO2zOQcNZIpaqR2qiYyGKqgSi1AhJZmsZ4ufY6qpP4LlYU
 fbJQzm6aT0fLAk2YrPMpC1mJ9YTadteAhksX5XDitNyJLvolpcWamsiek+iMEr07SZo3
 Z3bqyi8unYWTw8DNL6OYt9forpJkcG6/N64BlAVmpyAawcYVCaTVlrfi7C00sGTh/iTZ
 /b+vn2wQWiNNzrwuFcslVBj+Mt23Oqzz8nKnU96rMSlE2JfmX5x7SP9p12oZdUtVglpl
 4tT/3ojH9tBGYTcI1jBsVvgvQ5WEg0fAVNfrxwiDprgHIyc+48OiNYYcOeaRWG6FtGgw og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 345e0vuxbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 12:17:45 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09DG1b6r062186;
        Tue, 13 Oct 2020 12:17:45 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 345e0vuxas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 12:17:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09DGHGDE004812;
        Tue, 13 Oct 2020 16:17:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 34347gu9hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 16:17:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09DGHf5s33489224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 16:17:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF5DD11C050;
        Tue, 13 Oct 2020 16:17:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B212611C04C;
        Tue, 13 Oct 2020 16:17:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.65.195])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Oct 2020 16:17:38 +0000 (GMT)
Message-ID: <ba5f4d90c714eba5d5a1d822bca25305b40a73e1.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix sizeof mismatches
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 12:17:37 -0400
In-Reply-To: <0ceb198a-a313-f542-49cc-c0b9f6b1ea52@canonical.com>
References: <20201007110243.19033-1-colin.king@canonical.com>
         <55ae0b6152c84013d483b1bbecb28a425801c408.camel@perches.com>
         <a9a35d8b480112fe40b45392d0f0e9dcb5be536e.camel@linux.ibm.com>
         <ea06c7431075c57d274a9076077f28fd2c7634a5.camel@perches.com>
         <0ceb198a-a313-f542-49cc-c0b9f6b1ea52@canonical.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_06:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-12 at 19:10 +0100, Colin Ian King wrote:
> On 12/10/2020 19:06, Joe Perches wrote:
> > On Mon, 2020-10-12 at 13:51 -0400, Mimi Zohar wrote:
> >> On Wed, 2020-10-07 at 11:27 -0700, Joe Perches wrote:
> >>> On Wed, 2020-10-07 at 12:02 +0100, Colin King wrote:
> >>>> An incorrect sizeof is being used, sizeof(*fields) is not correct,
> >>>> it should be sizeof(**fields). This is not causing a problem since
> >>>> the size of these is the same. Fix this in the kmalloc_array and
> >>>> memcpy calls.
> >>> []
> >>>> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> >>> []
> >>>> @@ -216,11 +216,11 @@ int template_desc_init_fields(const char *template_fmt,
> >>>>  	}
> >>>>  
> >>>>  	if (fields && num_fields) {
> >>>> -		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
> >>>> +		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
> >>>>  		if (*fields == NULL)
> >>>>  			return -ENOMEM;
> >>>>  
> >>>> -		memcpy(*fields, found_fields, i * sizeof(*fields));
> >>>> +		memcpy(*fields, found_fields, i * sizeof(**fields));
> >>>
> >>> Maybe use kmemdup instead.
> >>>
> >>> 	if (fields && num_fields) {
> >>> 		*fields = kmemdup(found_fields, i * sizeof(**fields), GFP_KERNEL);
> >>> 		etc...
> >>>
> >>
> >> Thanks, Joe.  Since this patch will be backported, perhaps it would be
> >> better to leave this as a bug fix and upstream other changes
> >> independently.
> > 
> > IMO:
> > 
> > This patch doesn't need need backporting as it doesn't
> > actually fix anything other than a style defect.
> > 
> > void * and void ** are the same size.
> 
> indeed, same size, it's a semantic difference *and* a style fix :-)

Colin, based on Joe's suggestion of using kmemdup and his opinion of
not backporting this change, can I assume you'll address his comments
and re-post v3?

thanks,

Mimi

