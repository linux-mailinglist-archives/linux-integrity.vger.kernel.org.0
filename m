Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6361F255
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 13:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiKGMDD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 07:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKGMCt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 07:02:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1E2703
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 04:02:48 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7BKff3011948;
        Mon, 7 Nov 2022 12:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YWG7onJ0p9122vAyH9hh5EGrn2qJ56Xp5EQxgXIqPe0=;
 b=FJMHXdu/287OjJpOmzVGZi44yhU1svittzwyKTij/28tEc6Bz3TvP9m21QpNplFylg27
 w3D2IM6DARurxhnyH95s9JQ2nPFvtIeAZ+f72UrGzcT95L/0yzGP4/aV1m/vCwszVRNc
 gKV3PAf2nEPt0kpFGQzFBh5/4QHQI0pBjMGqGnpuIkBV/BDa1k5GBMlnVhZBCxWeKdNy
 cZezJLIg2Devy1QYDjFnRw2n/lZLYwKxyQu/+dHyh/ygppKqjq1CeHCm7uw4YlkBqMAe
 wnOy2URSkpdPkhpxlIXnI+4EkWexP0T5zQ+VIEnP+MGY2QkCw7ho6rWa2WBSu4PYPdbI mQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1tf14b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 12:02:41 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A7Bqtem027675;
        Mon, 7 Nov 2022 12:02:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3kngphua1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 12:02:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A7C2aqr20972158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Nov 2022 12:02:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86CF358059;
        Mon,  7 Nov 2022 12:02:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 352C75805D;
        Mon,  7 Nov 2022 12:02:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.191.11])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Nov 2022 12:02:38 +0000 (GMT)
Message-ID: <a2c90d97b2dc2540b3f3010fae47d1f5c6b91057.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5 02/17] log and reset 'errno' after
 failure to open non-critical files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Mon, 07 Nov 2022 07:02:37 -0500
In-Reply-To: <20221103223516.x5eyb65chj6th3e3@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
         <20221103183904.103562-3-zohar@linux.ibm.com>
         <20221103220531.ok6bwddhxmq6oxky@altlinux.org>
         <20221103222421.fhtdymd2spiejvuh@altlinux.org>
         <20221103223516.x5eyb65chj6th3e3@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jkpcMSJEG-aroynHn3BzJRWzUJ0V88Z9
X-Proofpoint-ORIG-GUID: jkpcMSJEG-aroynHn3BzJRWzUJ0V88Z9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_04,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-04 at 01:35 +0300, Vitaly Chikunov wrote:
> On Fri, Nov 04, 2022 at 01:24:21AM +0300, Vitaly Chikunov wrote:
> > On Fri, Nov 04, 2022 at 01:05:31AM +0300, Vitaly Chikunov wrote:
> > > Mimi,
> > > 
> > > On Thu, Nov 03, 2022 at 02:38:49PM -0400, Mimi Zohar wrote:
> > > > Define a log_errno_reset macro to emit the errno string at or near the
> > > > time of error, similar to the existing log_errno macro, but also reset
> > > > errno to avoid dangling or duplicate errno messages on exit.
> > > > 
> > > > The initial usage is for non-critical file open failures.
> > > > 
> > > > Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > ---
> > > >  src/evmctl.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > Reviewed-by: Vitaly Chikunov <vt@altlinux.org>

Thanks!

> > > 
> > > > 
> > > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > > index 0412bc0ac2b0..54123bf20f03 100644
> > > > --- a/src/evmctl.c
> > > > +++ b/src/evmctl.c
> > > > @@ -2055,7 +2060,6 @@ static int ima_measurement(const char *file)
> > > >  	int err_padded = -1;
> > > >  	int err = -1;
> > > >  
> > > > -	errno = 0;
> > > >  	memset(zero, 0, MAX_DIGEST_SIZE);
> > > >  
> > > >  	pseudo_padded_banks = init_tpm_banks(&num_banks);
> > > > @@ -2072,6 +2076,8 @@ static int ima_measurement(const char *file)
> > > >  		init_public_keys(imaevm_params.keyfile);
> > > >  	else				/* assume read pubkey from x509 cert */
> > > >  		init_public_keys("/etc/keys/x509_evm.der");
> > > > +	if (errno)
> > > > +		log_errno_reset(LOG_DEBUG, "Failed to initialize public keys");
> > > 
> > > Library prints appropriate error messages, so this is perhaps just to
> > > clear errno. But it's not necessarily completely failed, but maybe
> > > failure in one key. So I would say "Failure in initializing public
> > > keys" to be precise.
> > > 
> > > ps.
> > > 
> > > BTW, init_public_keys API call cannot return error except by errno,
> > > but it does not set it consistently so some errors may be missed.
> > > 
> > > init_public_keys loops calling read_pub_pkey
> > > 
> > >                 entry->key = read_pub_pkey(keyfile, 1);
> > >                 if (!entry->key) {
> > >                         free(entry);
> > >                         continue;
> > >                 }
> > > 
> > > and read_pub_pkey have such code:
> > > 
> > >         if (!keyfile)
> > >                 return NULL;
> > > 
> > > In that case some key is not read but we don't get any error notification.
> > > 
> > > I think it's legal, by the right of being library, so set `errno =
> > > EINVAL` there somewhere. But, I'm not sure where - as we should not
> > > clobber existing errno values. Perhaps, errno setting should be added to
> > > libimaevm consistently to all functions, but this is huge task, so I
> > > would not suggest to do it now. Just suggestion for the future
> > > developments, maybe.
> > 
> > Just to compare with other library - libtracefs sets errno _sometimes_,
> 
> It "is not consistent" in the sense that error in the API call does not
> have always errno set. And this is unlike we have for common libc API
> calls where errno is defined. (As a consequence we cannot just add
> strerror() to the printing errors from these APIs).
> 
> But, it's not necessarily there is standard or common practice about
> this matter.

The perror() man page seems to say that it is optional, but doesn't say
anything about libraries being self-consistent:  "When system call
fails, it usually returns -1 and sets the variable errno to a value
describing what went wrong.  (These values can be found in
<errno.h>.)  Many library functions do likewise."

> 
> 
> > for example, their API call tracefs_dynevent_get have:
> > 
> >   struct tracefs_dynevent *
> >   tracefs_dynevent_get(enum tracefs_dynevent_type type, const char *system,
> > 		       const char *event)
> >   {
> >   ...
> > 	  if (!event) {
> > 		  errno = -EINVAL;
> > 		  return NULL;
> > 	  }
> > 
> > 	  count = get_all_dynevents(type, system, &events);
> > 	  if (count <= 0)
> > 		  return NULL;
> >   ...
> > 
> > So it sets errno sometimes, but not always, which I am not sure is correct
> > approach. This needs to be discussed more with library experts.

Perhaps this isn't a question of self-consistency, but of who is
setting errno.  In the tracefs_dynevent_get() case, nothing else is
being called, so nothing could have set errno.  In the
get_all_dynevents() case, without looking at the code, something could
have already set errno.

As for the ima-evm-utils example, I agree read_pub_pkey() should return
-EINVAL when keyfile is NULL.  init_public_keys() verifies keyfile is
not NULL before calling read_pub_pkey(), so read_pub_pkey() returning
-EINVAL, shouldn't affect it.

-- 
Thanks,

Mimi

