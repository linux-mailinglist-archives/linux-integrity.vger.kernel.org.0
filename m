Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0314D046
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfFTOXN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 10:23:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54714 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTOXN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 10:23:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B6DDE72CC68;
        Thu, 20 Jun 2019 17:23:11 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9ABBF4A4A29;
        Thu, 20 Jun 2019 17:23:11 +0300 (MSK)
Date:   Thu, 20 Jun 2019 17:23:09 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 06/11] ima-evm-utils: Start converting find_keyid to
 use EVP_PKEY API
Message-ID: <20190620142309.kijmbgau6hspuodd@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
 <20190618135623.6861-7-vt@altlinux.org>
 <1560947190.3975.23.camel@linux.ibm.com>
 <20190619154339.e3kjc3niahwng64h@altlinux.org>
 <1560962810.3975.57.camel@linux.ibm.com>
 <20190620010713.wfmkjkf3fprgc3h6@altlinux.org>
 <1561036909.4525.29.camel@linux.ibm.com>
 <1561038049.4525.32.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561038049.4525.32.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Jun 20, 2019 at 09:40:49AM -0400, Mimi Zohar wrote:
> On Thu, 2019-06-20 at 09:21 -0400, Mimi Zohar wrote:
> > > > > >šIf so, why are there other changes in this patch?
> > > > > 
> > > > > There is no other changes beside stated in description.
> > > > 
> > > > Are the changes from read_pub_key() to read_pub_pkey() and
> > > > calc_keyid_v2() to calc_pkeyid_v2() needed for making find_keyid() a
> > > > wrapper for find_keyid_pkey()?
> > > 
> > > Of course. `entry->key' now have different type. If we keep old type
> > > (RSA) where will be nothing to wrap.
> > 
> > The question wasn't if the changes in init_public_keys() need to be
> > made, the question is its correlation to find_keyid(). šUnlesss I'm
> > missing something, find_keyid() is only called by verify_hash_v2(),
> > not calc_keyid_v2().
> 
> Ah, the list of keys needs to be in the appropriate format. šPerhaps
> add that info in the patch description.

Isn't this is implied by find_keyid()? It finds appropriate
`entry->key', and it's type is changed to EVP_PKEY, so both
init_public_keys() (where it fills `entry->key`) and find_keyid() (where
it returns `entry->key`) need to be changed.

Vitaly.
