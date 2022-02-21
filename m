Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68A14BEBB2
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiBUUTD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 15:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiBUUTC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 15:19:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07802E25;
        Mon, 21 Feb 2022 12:18:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF3C8B81785;
        Mon, 21 Feb 2022 20:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF0CC340E9;
        Mon, 21 Feb 2022 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645474716;
        bh=9TbUxu9ANLN8OJeZFahEkB+z9aXN3pXd7uUSAx+0lmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXcfKVPbCdm9aawIO2nH/n6q5QUuI6PfXTCH79dm7LfBqkiJKN+IkLamneBSlZFaD
         aSQ8Ofr9/JXNn1u9v/8li2HB82LlDBJTvosi4lRwDx6cL0QICXFjdggP13STkdl1yA
         VUWY+BSr49NuAU0LG1WUSypZTGsHbHV2MoZPs0h3ZKh6ZnsHaZ5YQS3tG9uc1YJF0x
         FOf/apA519BibyAkiqztootyMT6fqtkK/yYxsFbGvZwOyNM5VFggN1M7zjXycCIfU+
         IgdX8iXnzLnnqcoUt8DCTCRRUMBptQsrC/cuEZzOKw4GCLQ82AVHepEE8ojkWP0CMo
         F5Z7NnlKEhTJA==
Date:   Mon, 21 Feb 2022 21:19:12 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, corbet@lwn.net, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
Message-ID: <YhPzwOREseaU3RA5@iki.fi>
References: <20220215141953.1557009-1-yaelt@google.com>
 <0aa47dfaada88f1cbd2162784f8b77f43566f626.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa47dfaada88f1cbd2162784f8b77f43566f626.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 21, 2022 at 12:11:22AM -0500, Mimi Zohar wrote:
> On Tue, 2022-02-15 at 09:19 -0500, Yael Tzur wrote:
> > For availability and performance reasons master keys often need to be
> > released outside of a Key Management Service (KMS) to clients. It
> > would be beneficial to provide a mechanism where the
> > wrapping/unwrapping of data encryption keys (DEKs) is not dependent
> > on a remote call at runtime yet security is not (or only minimally)
> > compromised. Master keys could be securely stored in the Kernel and
> > be used to wrap/unwrap keys from Userspace.
> > 
> > The encrypted.c class supports instantiation of encrypted keys with
> > either an already-encrypted key material, or by generating new key
> > material based on random numbers. This patch defines a new datablob
> > format: [<format>] <master-key name> <decrypted data length>
> > <decrypted data> that allows to inject and encrypt user-provided
> > decrypted data. The decrypted data must be hex-ascii encoded.
> > 
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Yael Tzur <yaelt@google.com>
> 
> Thanks,  Yael.
> 
> This patch is now queued in the #next-integrity-testing branch.
> 
> -- 
> thanks,
> 
> Mimi
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
