Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC25C65D2A2
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjADM3J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 07:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjADM3I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 07:29:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7AB1A224;
        Wed,  4 Jan 2023 04:29:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D78B81628;
        Wed,  4 Jan 2023 12:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AB6C433EF;
        Wed,  4 Jan 2023 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672835345;
        bh=VpZBnDQgpO+oMahbk71quy/7eaPxvqN/v3XHlU5yAs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvP6ASrZMvHhcAuGAOT+jzapK5d4RDlHuP7MNzgblqPmZshleLtD6q8jIngbDODgC
         mS0B6DhdIeJcf+JIBlOej9FcVxj9GaXcQXO/O4XGk6/jskWiCAXqWHGpA95RZRSaMn
         MedCrXfgpzFU2Gbj7mUD3MoP9XeW/jmuCNuGopv1K4JtY+347xB69jAcXQabIjzt59
         5p24LKC132KD3ukQLYlqpnYjfR4WeJRrZTi1LIG1PMBenCr59P7LI1K22FG29+qAgh
         GpFKfoL3w1AM37xqSxzvMQKhWP0QtmuqrLFOkhB7MkEE6PktRyg5dqLG3SedrMrgAT
         Unx2kERSX0QAw==
Date:   Wed, 4 Jan 2023 12:29:02 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 03/10] KEYS: X.509: Parse Basic Constraints for CA
Message-ID: <Y7VxDloaHyF8cX5j@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-4-eric.snowberg@oracle.com>
 <b0f29738b919e2705d770017f2f1eb0542c2fad4.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f29738b919e2705d770017f2f1eb0542c2fad4.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 15, 2022 at 06:10:04AM -0500, Mimi Zohar wrote:
> > diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> > index a299c9c56f40..7c5c0ad1c22e 100644
> > --- a/crypto/asymmetric_keys/x509_parser.h
> > +++ b/crypto/asymmetric_keys/x509_parser.h
> > @@ -38,6 +38,7 @@ struct x509_certificate {
> >  	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
> >  	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
> >  	bool		blacklisted;
> > +	bool		root_ca;		/* T if basic constraints CA is set */
> >  }; 
> 
> The variable "root_ca" should probably be renamed to just "ca", right?

Perhaps is_ca?

BR, Jarkko
