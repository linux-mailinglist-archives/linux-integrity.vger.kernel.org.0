Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB60465D1C8
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjADLv4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjADLvz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:51:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2513CF7;
        Wed,  4 Jan 2023 03:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B34DCB80E65;
        Wed,  4 Jan 2023 11:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCE2C433EF;
        Wed,  4 Jan 2023 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672833112;
        bh=zQS2zHLvUfm3ytaA5OXllsya+YD6VZ9Yf2wEgb6vkEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htNPTPr1dxEWwUXjObrE4uPyESYm4LBrOY9hj2w9h7gwVjDe2BN5nbr9bsohdg0P2
         //pXYRpj77dPfSKATahmVzBJ/4AMQYYry0Q3Lant+p7rUOEz5a0BCwTOta63SOyBWo
         KGDzfJplwOLm97mGuBaSQfW9e+F9oHhcV6wVwhf1/wuiS0cmOTW8abV1gXryZ929fW
         qiOD+ZnsGOQo8WyPG+M7cNTCJlTgmlWBajl9eUHFAS6z0gQVi1uqU5QK5gzswJ98Jr
         8c1i+icTrFo3JBb6W7afeFzR94+QMzcbDiv2pqdV5qPmNQ0/EqVYCxz5GEAsP7bq9B
         iFXtV6kbowejA==
Date:   Wed, 4 Jan 2023 11:51:49 +0000
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
Message-ID: <Y7VoVTGtGi6NmA8O@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-10-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003401.4086781-10-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 13, 2022 at 07:34:00PM -0500, Eric Snowberg wrote:
> +/**
> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @trust_keyring: Unused.
> + *
> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> + * certificate as being ok to link.
> + *
> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> + * crypto, or some other error if there is a matching certificate but
> + * the signature check cannot be performed.
> + */
> +int restrict_link_by_ca(struct key *dest_keyring,
> +			const struct key_type *type,
> +			const union key_payload *payload,
> +			struct key *trust_keyring)

Why you want to define trust_keyring, other than matching the parameter
list in restrict_link_by_signature()?

Also if it is unused, it should be then just "struct key *)", right?

BR, Jarkko
