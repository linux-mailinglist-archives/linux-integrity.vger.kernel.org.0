Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4777E239D9F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHCDJM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 2 Aug 2020 23:09:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgHCDJM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Aug 2020 23:09:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0733412Z142896;
        Sun, 2 Aug 2020 23:09:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32p9bn98jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Aug 2020 23:09:07 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 073348lU143269;
        Sun, 2 Aug 2020 23:09:07 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32p9bn98hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Aug 2020 23:09:07 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07331ZxT015327;
        Mon, 3 Aug 2020 03:09:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 32n017s141-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 03:09:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073392HS25559490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 03:09:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75A5942042;
        Mon,  3 Aug 2020 03:09:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 395F94203F;
        Mon,  3 Aug 2020 03:09:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.0.172])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 03:09:01 +0000 (GMT)
Message-ID: <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Sun, 02 Aug 2020 23:09:00 -0400
In-Reply-To: <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <20200731210653.p5m4efy52melqwgs@altlinux.org>
         <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_01:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030021
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-31 at 18:32 -0400, Mimi Zohar wrote:
> 
> > - Or even better, Bionic (which is supported by Travis) should have
> >   gost-engine already in the libengine-gost-openssl1.1 package.
> > 
> >   In that case `.travis.yml` should have `dist: bionic`.
> >     https://docs.travis-ci.com/user/reference/bionic/
> 
> Yes, for the internal git repo I made this change.   The internal
> travis support for bionic is different than the external
> travis.   I'll post what I have as an RFC.

The internal travis support on ppc defaults to using Bionic, but the
way of specifying it is different.

+os: linux-ppc64le
 language: C
 addons:
  apt:

Mimi

