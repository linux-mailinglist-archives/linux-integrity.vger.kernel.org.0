Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0FA65D1DC
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbjADLzW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjADLyx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:54:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6852A1EC45;
        Wed,  4 Jan 2023 03:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DE8613E9;
        Wed,  4 Jan 2023 11:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF661C433EF;
        Wed,  4 Jan 2023 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672833289;
        bh=2h492Ot3amT7yprfX9Jew+1cyS+yy617WjcWHESIjPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzEOndpCGhaX4IzFlcKlYEqBGOiXvlbMxiP5/5bS/88n68Qrez6S2JkDpx1Qkp9iX
         aj9jcOcOZeiM12QXrh1H3tewVkey6754EnueMTsaYkB+KY7liqiPCVihVbQoH88Txq
         W5RoQZ5QH3bnVJzmjL75JscQe6H4/dkxaFpv7TYgNyXKhFweTBhQjsMfY2CSsA1amb
         hFj6q8Ty8oSSvxGFUdMY0HY83hZDcO0VhGKUus1CttVFTVZyFkhTmFTqwUKjxACbsI
         LyxtpOQLvBww2zYDb4SkhkIThtSEnsDoZZ4dpPKxJbqMTGzJLUQeYiQn6x4GxCnq5V
         6K3NsT+jEoluw==
Date:   Wed, 4 Jan 2023 11:54:46 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 09/10] KEYS: CA link restriction
Message-ID: <Y7VpBk9AfZ1Kx/8z@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-10-eric.snowberg@oracle.com>
 <Y7VoVTGtGi6NmA8O@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7VoVTGtGi6NmA8O@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 04, 2023 at 11:51:52AM +0000, Jarkko Sakkinen wrote:
> On Tue, Dec 13, 2022 at 07:34:00PM -0500, Eric Snowberg wrote:
> > +/**
> > + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> > + * @dest_keyring: Keyring being linked to.
> > + * @type: The type of key being added.
> > + * @payload: The payload of the new key.
> > + * @trust_keyring: Unused.
> > + *
> > + * Check if the new certificate is a CA. If it is a CA, then mark the new
> > + * certificate as being ok to link.
> > + *
> > + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> > + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> > + * crypto, or some other error if there is a matching certificate but
> > + * the signature check cannot be performed.
> > + */
> > +int restrict_link_by_ca(struct key *dest_keyring,
> > +			const struct key_type *type,
> > +			const union key_payload *payload,
> > +			struct key *trust_keyring)
> 
> Why you want to define trust_keyring, other than matching the parameter
> list in restrict_link_by_signature()?
> 
> Also if it is unused, it should be then just "struct key *)", right?

Please ignore, I forgot how this worked, i.e. "restriction" is set to
the correct function so this looks correct to me :-) So it's good.
Sorry for the confusion.

BR, Jarkko


