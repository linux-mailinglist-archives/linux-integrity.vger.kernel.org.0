Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A01C9F81
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 02:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHAYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 20:24:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEHAYG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 20:24:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04802tMJ127321;
        Thu, 7 May 2020 20:23:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwc2ca0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 20:23:47 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0480K9Dq165442;
        Thu, 7 May 2020 20:23:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwc2c9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 20:23:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0480Kt1X007960;
        Fri, 8 May 2020 00:23:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5va3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 00:23:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0480Nh4G46661768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 00:23:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B4E52051;
        Fri,  8 May 2020 00:23:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.201])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0674E5204F;
        Fri,  8 May 2020 00:23:41 +0000 (GMT)
Message-ID: <1588897421.5685.152.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: evm: Fix RCU list related warnings.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        madhuparnabhowmik10@gmail.com
Cc:     jmorris@namei.org, serge@hallyn.com, paulmck@kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 07 May 2020 20:23:41 -0400
In-Reply-To: <20200508101402.267ca0f2@canb.auug.org.au>
References: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
         <20200508101402.267ca0f2@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_17:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005070183
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stephen,

On Fri, 2020-05-08 at 10:14 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 30 Apr 2020 21:32:05 +0530 madhuparnabhowmik10@gmail.com wrote:
> >
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch fixes the following warning and few other
> > instances of traversal of evm_config_xattrnames list:
> > 
> > [   32.848432] =============================
> > [   32.848707] WARNING: suspicious RCU usage
> > [   32.848966] 5.7.0-rc1-00006-ga8d5875ce5f0b #1 Not tainted
> > [   32.849308] -----------------------------
> > [   32.849567] security/integrity/evm/evm_main.c:231 RCU-list traversed in non-reader section!!
> > 
> > Since entries are only added to the list and never deleted,
> > use list_For_each_entry_lockless() instead of
> > list_for_each_entry_rcu() for traversing the list.
> > Also, add a relevant comment in evm_secfs.c to indicate this fact.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  security/integrity/evm/evm_crypto.c | 2 +-
> >  security/integrity/evm/evm_main.c   | 4 ++--
> >  security/integrity/evm/evm_secfs.c  | 9 ++++++++-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index 35682852ddea..b2dc87da5f50 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -207,7 +207,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
> >  	data->hdr.length = crypto_shash_digestsize(desc->tfm);
> >  
> >  	error = -ENODATA;
> > -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> > +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
> >  		bool is_ima = false;
> >  
> >  		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index d361d7fdafc4..0d36259b690d 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -97,7 +97,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
> >  	if (!(inode->i_opflags & IOP_XATTR))
> >  		return -EOPNOTSUPP;
> >  
> > -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> > +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
> >  		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
> >  		if (error < 0) {
> >  			if (error == -ENODATA)
> > @@ -228,7 +228,7 @@ static int evm_protected_xattr(const char *req_xattr_name)
> >  	struct xattr_list *xattr;
> >  
> >  	namelen = strlen(req_xattr_name);
> > -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> > +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
> >  		if ((strlen(xattr->name) == namelen)
> >  		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
> >  			found = 1;
> > diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> > index 39ad1038d45d..cfc3075769bb 100644
> > --- a/security/integrity/evm/evm_secfs.c
> > +++ b/security/integrity/evm/evm_secfs.c
> > @@ -232,7 +232,14 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> >  		goto out;
> >  	}
> >  
> > -	/* Guard against races in evm_read_xattrs */
> > +	/*
> > +	 * xattr_list_mutex guards against races in evm_read_xattrs().
> > +	 * Entries are only added to the evm_config_xattrnames list
> > +	 * and never deleted. Therefore, the list is traversed
> > +	 * using list_for_each_entry_lockless() without holding
> > +	 * the mutex in evm_calc_hmac_or_hash(), evm_find_protected_xattrs()
> > +	 * and evm_protected_xattr().
> > +	 */
> >  	mutex_lock(&xattr_list_mutex);
> >  	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
> >  		if (strcmp(xattr->name, tmp->name) == 0) {
> 
> I will apply this to linux-next today.
> 
> Is there something stopping this being applied to a tree?  And does it
> need to be sent to Linus soon?

Sorry for the delay in pushing this and other fixes to the next-
integrity branch.  It's in my next-integrity-testing branch.

This isn't a bug per-se, just annotating the reason for the lack of
locking.

thanks,

Mimi
