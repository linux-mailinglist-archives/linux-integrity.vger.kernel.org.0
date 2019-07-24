Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79400737A0
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfGXTRg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 15:17:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45008 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGXTRg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 15:17:36 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D5AC372CCDA;
        Wed, 24 Jul 2019 22:17:33 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B43514A4AE8;
        Wed, 24 Jul 2019 22:17:33 +0300 (MSK)
Date:   Wed, 24 Jul 2019 22:17:33 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        "BrunoE.O.Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: ima-evm-utils:  library version
Message-ID: <20190724191733.466tex2pqoikmyfl@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>,
        "BrunoE.O.Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <1563972698.4245.21.camel@linux.ibm.com>
 <20190724172801.y64bs2byyuqfsezf@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724172801.y64bs2byyuqfsezf@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Btw,

On Wed, Jul 24, 2019 at 08:28:01PM +0300, Vitaly Chikunov wrote:
> On Wed, Jul 24, 2019 at 08:51:38AM -0400, Mimi Zohar wrote:
> > 
> > In preparing the ima-evm-utils v1.2 release, I noticed that the
> > library version was never updated. šIt is still "0.0.0". šShould I set
> > it to something? šIf so, what versioning scheme do you recommend -
> > using the libtool current[:revision[:age]], prepending the release
> > version on the .so, or suffixing the release version on the .so?
> 
> libtool rules should be followed:
> 
>   https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
> 
> I think you should change 0.0.0 to 1.0.0 just before release. Since we are
> changed ABI of calc_keyid_v2 (RSA *key -> EVP_PKEY *pkey). (There is also
> changes to read_pub_pkey and get_filesize.)

Speaking about ABI:

   src/ima-evm-utils (tests)$ readelf --dyn-syms src/.libs/libimaevm.so | egrep -vw 'UND|_edata|_fini|_init|_end|__bss_start'
   Num:    Value          Size Type    Bind   Vis      Ndx Name
    74: 0000000000003bf6  1047 FUNC    GLOBAL DEFAULT   12 sign_hash_v1
    75: 0000000000002c5b   783 FUNC    GLOBAL DEFAULT   12 read_pub_pkey
    77: 000000000000400d   836 FUNC    GLOBAL DEFAULT   12 sign_hash_v2
    78: 0000000000004351    56 FUNC    GLOBAL DEFAULT   12 sign_hash
    81: 0000000000003795   198 FUNC    GLOBAL DEFAULT   12 key2bin
    83: 00000000000025f3  1640 FUNC    GLOBAL DEFAULT   12 ima_calc_hash
    84: 0000000000003204   232 FUNC    GLOBAL DEFAULT   12 get_hash_algo
    85: 00000000000032ec   836 FUNC    GLOBAL DEFAULT   12 verify_hash
    87: 0000000000003630   357 FUNC    GLOBAL DEFAULT   12 ima_verify_signature
    88: 000000000000385b   204 FUNC    GLOBAL DEFAULT   12 calc_keyid_v1
    89: 0000000000205d20   144 OBJECT  GLOBAL DEFAULT   20 hash_algo_name
    90: 0000000000003927   308 FUNC    GLOBAL DEFAULT   12 calc_keyid_v2
    91: 0000000000002566    34 FUNC    GLOBAL DEFAULT   12 dump
    92: 0000000000003a5b   411 FUNC    GLOBAL DEFAULT   12 init_public_keys
    93: 0000000000205c80   160 OBJECT  GLOBAL DEFAULT   20 pkey_hash_algo
    94: 00000000002062c0    32 OBJECT  GLOBAL DEFAULT   24 params
    95: 0000000000205be0   160 OBJECT  GLOBAL DEFAULT   20 pkey_hash_algo_kern
    96: 0000000000002588   107 FUNC    GLOBAL DEFAULT   12 get_hash_algo_by_id
    97: 0000000000002f6a   113 FUNC    GLOBAL DEFAULT   12 read_pub_key
    98: 0000000000002509    93 FUNC    GLOBAL DEFAULT   12 do_dump

This looks not very good. Names like `dump', `do_dump', `params' aren't good
for public ABI. And should be prefixed, or removed. Probably, some (or all)
others too. Prefix could be something like `ima_', like in `ima_calc_hash'.

Thanks,
