Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601553CFA02
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhGTMVi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 08:21:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230427AbhGTMVe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 08:21:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KCXB9h129580;
        Tue, 20 Jul 2021 09:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Riwv19ZwdFbDzNPVPECbfy4YpeThSBLte5/J/rjnWZc=;
 b=JaVYWvl1BTl7VKakCcYH3/3F5qvcdSREEAF2/nxXcU465CjbGE8dAI7LrVPNbScl8oII
 h04Y7mMFYEGJ0d0G+ZbJ4Dz4uNj5lVI1qOlrdCZbB+0avoE7lTpyiFlGU/TuaT5ZwZHA
 LLHgRIT0L46+jzPbxSOKq3UsmFmI6AvTa6CbJLTs2jy2sdsr7a/f7nAolYCYMIP2smuk
 wCCxG+TgdqTkwlC12vm/0O/xpb4XcjaZJ0Kywu33porPjGN7hYE3R3sSK1HyiMCMVZ2i
 QhNkPA1uEto4R98y+yrS69SNAWGJ7KnagIiesdLxDHlEEq6zzLGKvoU1Ixk20+s0yfGW CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wwg632xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 09:02:00 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16KCXDPO129704;
        Tue, 20 Jul 2021 09:01:59 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wwg632vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 09:01:59 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16KCvOPR027500;
        Tue, 20 Jul 2021 13:01:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 39upfh8rxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 13:01:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16KD1sfh27132286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 13:01:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DCE0AE045;
        Tue, 20 Jul 2021 13:01:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC8DAE04D;
        Tue, 20 Jul 2021 13:01:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.56.226])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Jul 2021 13:01:51 +0000 (GMT)
Message-ID: <999c3297f71e5f7d69b555bc8c999729e8b1ae31.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] ima: Return int in the functions to measure a
 buffer
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>
Cc:     "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "prsriva02@gmail.com" <prsriva02@gmail.com>,
        "tusharsu@linux.microsoft.com" <tusharsu@linux.microsoft.com>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Date:   Tue, 20 Jul 2021 09:01:50 -0400
In-Reply-To: <bd953894da3041d5969da645db2f982e@huawei.com>
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
         <20210705090922.3321178-3-roberto.sassu@huawei.com>
         <2f4920dbdb16156e1af5cf78f592a5cf07ec3176.camel@linux.ibm.com>
         <bd953894da3041d5969da645db2f982e@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HlskwCogQeEVE3B_1NA-ttdKagDUSF7_
X-Proofpoint-ORIG-GUID: Ejs5htwOyDS0irQ8lIeHBY5vsVk1JFWD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_07:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-07-20 at 12:38 +0000, Roberto Sassu wrote:
> > > This patch modifies the return type from void to int, and returns 0 if the
> > > buffer has been successfully measured, a negative value otherwise.
> > 
> > Needed here is an explanation as to why ima_measure_critical_data() is
> > special.
> 
> We don't want to unnecessarily calculate the digest twice.

That's what the "iint" cache is for.  .  This needs more a of an
explaintion as to why  ima_measure_critical_data() is special.

thanks,

Mimi

