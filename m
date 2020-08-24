Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E094525087D
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHXSxO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 14:53:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40618 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgHXSxL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 14:53:11 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4D59320B4908;
        Mon, 24 Aug 2020 11:53:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D59320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598295190;
        bh=PEVXNrC7qCWoYQ6cBtLYoPpmAUDgidOX4sUr/CphXTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7QLWqV+9eLHIC/H822jOb7WbBoiRn0rn1itquDa3hPXynwCr51RWyETdkczvlskK
         FuYDBXnHn7fnH9PIriiAm57ikZpiyUKWRT/86CvnUmCjDZ6isf2YubKJnDxZIASBTa
         fZs4mDmS0K7mJNoJ2t+D4iepSFSAoARMBdOTZwKE=
Date:   Mon, 24 Aug 2020 13:53:08 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ima: Fix keyrings race condition and other key
 related bugs
Message-ID: <20200824185308.GD4148@sequoia>
References: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
 <839d2b185ba482d664edd3fda7c03965543553fa.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839d2b185ba482d664edd3fda7c03965543553fa.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-08-24 14:44:55, Mimi Zohar wrote:
> Hi Tyler,
> 
> On Tue, 2020-08-11 at 14:26 -0500, Tyler Hicks wrote:
> > v2:
> >  - Always return an ERR_PTR from ima_alloc_rule_opt_list() (Nayna)
> >  - Add Lakshmi's Reviewed-by to both patches
> >  - Rebased on commit 3db0d0c276a7 ("integrity: remove redundant
> >    initialization of variable ret") of next-integrity
> > v1: https://lore.kernel.org/lkml/20200727140831.64251-1-tyhicks@linux.microsoft.com/
> > 
> > Nayna pointed out that the "keyrings=" option in an IMA policy rule
> > should only be accepted when CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is
> > enabled:
> > 
> >  https://lore.kernel.org/linux-integrity/336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com/
> > 
> > While fixing this, the compiler warned me about the potential for the
> > ima_keyrings pointer to be NULL despite it being used, without a check
> > for NULL, as the destination address for the strcpy() in
> > ima_match_keyring().
> > 
> > It also became apparent that there was not adequate locking around the
> > use of the pre-allocated buffer that ima_keyrings points to. The kernel
> > keyring has a lock (.sem member of struct key) that ensures only one key
> > can be added to a given keyring at a time but there's no protection
> > against adding multiple keys to different keyrings at the same time.
> > 
> > The first patch in this series fixes both ima_keyrings related issues by
> > parsing the list of keyrings in a KEY_CHECK rule at policy load time
> > rather than deferring the parsing to policy check time. Once that fix is
> > in place, the second patch can enforce that
> > CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS must be enabled in order to use
> > "func=KEY_CHECK" or "keyrings=" options in IMA policy.
> 
> Thank you for fixing and cleaning up the existing keyring policy
> support. 
> 
> > 
> > The new "keyrings=" value handling is done in a generic manner that can
> > be reused by other options in the future. This seems to make sense as
> > "appraise_type=" has similar style (though it doesn't need to be fully
> > parsed at this time) and using "|" as an alternation delimiter is
> > becoming the norm in IMA policy.
> 
> Yes, thank you.  Better extending existing key value pairs than
> defining new boot command line options.
> 
> This patch set is now queued in next-integrity-testing.

Thanks! I'm glad you found it useful.

Tyler

> 
> Mimi
