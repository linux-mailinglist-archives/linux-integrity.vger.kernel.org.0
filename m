Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26E74C4C2
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 03:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfFTBHQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 21:07:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46356 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfFTBHQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 21:07:16 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0877672CC64;
        Thu, 20 Jun 2019 04:07:14 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E4F754A4A29;
        Thu, 20 Jun 2019 04:07:13 +0300 (MSK)
Date:   Thu, 20 Jun 2019 04:07:13 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 06/11] ima-evm-utils: Start converting find_keyid to
 use EVP_PKEY API
Message-ID: <20190620010713.wfmkjkf3fprgc3h6@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
 <20190618135623.6861-7-vt@altlinux.org>
 <1560947190.3975.23.camel@linux.ibm.com>
 <20190619154339.e3kjc3niahwng64h@altlinux.org>
 <1560962810.3975.57.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560962810.3975.57.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jun 19, 2019 at 12:46:50PM -0400, Mimi Zohar wrote:
> On Wed, 2019-06-19 at 18:43 +0300, Vitaly Chikunov wrote:
> > On Wed, Jun 19, 2019 at 08:26:30AM -0400, Mimi Zohar wrote:
> > > On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> > > > New find_keyid_pkey() accepts EVP_PKEY. Old find_keyid() calls
> > > > find_keyid_pkey(), but still return RSA key.
> > > > 
> > > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > 
> > > With titles starting with "Start converting", it leaves me wondering
> > > whether these patches are bisect safe. šDoes this patch make
> > > find_keyid() a wrapper for find_keyid_pkey()?
> > 
> > Yes.
> > 
> > >šDo all callers of find_keyid() continue to work properly?
> > 
> > Yes.
> > 
> > >šIf so, why are there other changes in this patch?
> > 
> > There is no other changes beside stated in description.
> 
> Are the changes from read_pub_key() to read_pub_pkey() and
> calc_keyid_v2() to calc_pkeyid_v2() needed for making find_keyid() a
> wrapper for find_keyid_pkey()?

Of course. `entry->key' now have different type. If we keep old type
(RSA) where will be nothing to wrap.

Thanks,


