Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089F620F349
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgF3LA5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jun 2020 07:00:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732578AbgF3LA5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jun 2020 07:00:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UAW5uE004699;
        Tue, 30 Jun 2020 07:00:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ycd52wpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:00:55 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UAXjbF018111;
        Tue, 30 Jun 2020 07:00:55 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ycd52wnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:00:55 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UAt6BY009757;
        Tue, 30 Jun 2020 11:00:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 31wwr81nmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 11:00:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UB0o2R56492310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 11:00:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 290A9AE05F;
        Tue, 30 Jun 2020 11:00:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62A08AE071;
        Tue, 30 Jun 2020 11:00:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.137.220])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 11:00:49 +0000 (GMT)
Message-ID: <1593514848.5085.82.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        erichte@linux.ibm.com, nayna@linux.ibm.com
Date:   Tue, 30 Jun 2020 07:00:48 -0400
In-Reply-To: <20200629234744.GA2756@glitch>
References: <20200623202640.4936-1-bmeneg@redhat.com>
         <20200623202640.4936-3-bmeneg@redhat.com>
         <1593204023.27152.476.camel@linux.ibm.com> <20200629234744.GA2756@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_04:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 cotscore=-2147483648 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300073
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-29 at 20:47 -0300, Bruno Meneguele wrote:

> 
> > I'm not if the "secure_boot" flag is available prior to calling
> > default_appraise_setup(), but if it is, you could modify the test
> > there to also check if the system is booted in secure boot mode (eg.
> > IS_ENABLED(CONFIG_IMA_APPRAISE_BOOTPARAM) &&
> > !arch_ima_get_secureboot())
> > 
> 
> Well pointed. I built a custom x86 kernel with some workaround to get
> this flag status within default_appraise_setup() and as a result the
> flag is was correctly available. 
> 
> Considering the nature of this flag (platform's firmware (in all
> arches?)) can we trust that every arch supporting secure/trusted boot
> will have it available in the __setup() call time?

Calling default_appraise_setup() could be deferred.

> 
> > > +		/* In secure and/or trusted boot the appraisal must be
> > > +		 * enforced, regardless kernel parameters, preventing
> > > +		 * runtime changes */
> > 
> > Only "appraise" rules are enforced.
> > 
> 
> Hmm.. do you mean the comment wording is wrong/"could be better",
> pointing the "appraise" action explicitly?

No, it's more than just the comment.  Like "trusted boot", IMA-
measurement only measures files, never enforces integrity.
 "ima_appraise" mode is only applicable to IMA-appraisal.

Mimi
