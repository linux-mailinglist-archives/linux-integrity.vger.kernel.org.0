Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6EB26543
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfEVN5S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 09:57:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbfEVN5S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 09:57:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MDlMkJ023790
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 09:57:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sn6u231vw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 09:57:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 May 2019 14:57:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 14:57:13 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MDvCCv38731924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 13:57:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43F7D5205F;
        Wed, 22 May 2019 13:57:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.204])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7E5605204E;
        Wed, 22 May 2019 13:57:11 +0000 (GMT)
Subject: Re: sleep in selinux_audit_rule_init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Janne Karhunen <janne.karhunen@gmail.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 22 May 2019 09:57:00 -0400
In-Reply-To: <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
         <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
         <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
         <1558530022.4347.11.camel@linux.ibm.com>
         <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052213-0016-0000-0000-0000027E58A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052213-0017-0000-0000-000032DB4ADE
Message-Id: <1558533420.4347.30.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220100
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-05-22 at 09:16 -0400, Stephen Smalley wrote:
> On 5/22/19 9:00 AM, Mimi Zohar wrote:
> > On Wed, 2019-05-22 at 08:41 -0400, Stephen Smalley wrote:
> >> Another potentially worrisome aspect of the current
> >> ima_lsm_update_rules() logic is that it does a BUG_ON() if the attempt
> >> to update the rule fails, which could occur if e.g. one had an IMA
> >> policy rule based on a given domain/type and that domain/type were
> >> removed from policy (e.g. via policy module removal).  Contrast with the
> >> handling in audit_dupe_lsm_field().  The existing ima_lsm_update_rules()
> >> logic could also yield a BUG_ON upon transient memory allocation failure.
> > 
> > The original design was based on the assumption that SELinux labels
> > could not be removed, only new ones could be added.  Sounds like that
> > isn't the case any longer.
> 
> That's never really been the case for SELinux; it has always been 
> possible to reload with a policy that renders previously valid security 
> contexts invalid.  What has changed over time is the ability of SELinux 
> to gracefully handle the situation where a security context is rendered 
> invalid upon a policy reload and then later restored to validity via a 
> subsequent policy reload (e.g. removing a policy module and then 
> re-adding it), but even that deferred mapping of contexts support has 
> been around since 2008.
> 
> What you are likely thinking of is the conventional practice of 
> distributions, which is generally to not remove domains/types from their 
> policy or to at least retain a type alias for compatibility reasons. 
> But that's just a convention, not guaranteed by any mechanism, and users 
> are free to remove policy modules.

Ok.  The question is then how should IMA handle missing domains/types.
 Just dropping IMA policy rules doesn't sound safe, nor does skipping
rules in case the domains/types are restored.

Mimi  

