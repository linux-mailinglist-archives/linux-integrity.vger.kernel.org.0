Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6413C639BCE
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiK0Ql6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiK0Ql6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 11:41:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348964CF;
        Sun, 27 Nov 2022 08:41:56 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ARDsK1B009989;
        Sun, 27 Nov 2022 16:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=k6hjmKrYDOyQ1On21ylkpvTYpuTpRppN+bfdSxZ3qw8=;
 b=sAZIOq6aXYKMDJezR4tbMr12JlY7xhtHu7XrfS20W4eq6xcismuv/mLt8zmg46HTmLhP
 FHcq+6oC8OQVZ5hQoMowPTEY30a0xEGjrCzsIfXWQZ0gKR7KO8t33AlX68EG0WInnLqR
 JCAHxOEZ/2kbDNTMnK/KT85PC7OuNUskj7gGpBQkgydxj1iqwP0vjqBKogco6qYMCb/k
 cwINmMtM1j8tdIBpA3BsRiMQvIuy/Dc10ocUFVVqSET0AudfriojmtB0KLNkziml5jwg
 S70kW0/QbkxV4ofj6qQtA50KpwpriAVEixHvONbdAG76eZIvntxtvoKTqCju40agsh1C EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vy1kkxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Nov 2022 16:41:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ARGY1Jp003773;
        Sun, 27 Nov 2022 16:41:33 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vy1kkxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Nov 2022 16:41:33 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ARGZrUL005409;
        Sun, 27 Nov 2022 16:41:32 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3m3ae92hka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Nov 2022 16:41:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ARGfawB66060702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Nov 2022 16:41:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA6B67805E;
        Sun, 27 Nov 2022 17:48:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE4AB7805C;
        Sun, 27 Nov 2022 17:47:58 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.83.181])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 27 Nov 2022 17:47:58 +0000 (GMT)
Message-ID: <53e3d7f9cc50e1fe9cf67e7889c6b5498580e5d9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Date:   Sun, 27 Nov 2022 11:41:26 -0500
In-Reply-To: <Y4ORZT2t/KhL5jfn@kernel.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
         <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
         <Y4ORZT2t/KhL5jfn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cEa4o1PP5XpzkFbD6hFuYeIpEmegleO2
X-Proofpoint-ORIG-GUID: bvbRP1YdK5h8wgSgpkrgDUZ_F5ZAInju
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-27_08,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=917 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211270139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2022-11-27 at 18:33 +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 14, 2022 at 12:11:20PM -0500, James Bottomley wrote:
> > On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
> > > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > > restricts usermode's ability to extend or reset PCR 23.
> > 
> > Could I re ask the question here that I asked of Matthew's patch
> > set:
> > 
> > https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
> > 
> > Which was could we use an NVRAM index in the TPM instead of a PCR? 
> > The reason for asking was that PCRs are rather precious and might
> > get more so now that Lennart has some grand scheme for using more
> > of them in his unified boot project.  Matthew promised to play with
> > the idea but never got back to the patch set to say whether he
> > investigated this or not.
> 
> Even for PCR case it would be better to have it configurable through
> kernel command-line, including a disabled state, which would the
> default.
> 
> This would be backwards compatible, and if designed properly, could
> more easily extended for NV index later on.


Um how?  The observation is in the above referenced email is that PCR23
is reserved in the TCG literature for application usage.  If any
application is actually using PCR23 based on that spec then revoking
access to user space will cause it to break.  This is an ABI change
which is not backwards compatible.  You can call it a distro problem if
it's command line configurable, but the default would be what most
distros take, so it's rather throwing them under the bus if there is an
application using it.

Of course, if no application is actually using PCR23, then it's
probably OK to use it in the kernel and make it invisible to user
space, but no evidence about this has actually been presented.

James

