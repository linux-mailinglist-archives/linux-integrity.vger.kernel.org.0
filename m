Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629DA723511
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 04:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjFFCJh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 22:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFFCJh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 22:09:37 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D96114;
        Mon,  5 Jun 2023 19:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686017374;
        bh=892MxsEj+fA8J2c25vw4Ei7wKOHzFB9/P90RLEWrmyM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qKi01xOQlRQZlhcv9xTctxlgReNwDUyhCTz4/MSF/XCgPUq2eD+b3I8xuD1J7WX61
         HBhDM1JUOv4Qf6kFO5qnBbIVFsFSHmLDyuTOO4NybVSufmXHiMDmE++Ehd8wgsCojf
         PlcUKADHZkSxtmQ+pn8PxTRp9um21ssX4me6QpfU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 99AF81286698;
        Mon,  5 Jun 2023 22:09:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xfdQDF7Q92in; Mon,  5 Jun 2023 22:09:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1686017374;
        bh=892MxsEj+fA8J2c25vw4Ei7wKOHzFB9/P90RLEWrmyM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qKi01xOQlRQZlhcv9xTctxlgReNwDUyhCTz4/MSF/XCgPUq2eD+b3I8xuD1J7WX61
         HBhDM1JUOv4Qf6kFO5qnBbIVFsFSHmLDyuTOO4NybVSufmXHiMDmE++Ehd8wgsCojf
         PlcUKADHZkSxtmQ+pn8PxTRp9um21ssX4me6QpfU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CF90B128603A;
        Mon,  5 Jun 2023 22:09:33 -0400 (EDT)
Message-ID: <be5c726340a32914d0f79b38b015c0a8ea4a7780.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 06/13] tpm: add buffer function to point to returned
 parameters
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 05 Jun 2023 22:09:30 -0400
In-Reply-To: <CSCLXUWIMPCG.D6K372YA1HMK@suppilovahvero>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
         <20230403214003.32093-7-James.Bottomley@HansenPartnership.com>
         <d5c86f6f-6854-c649-d2a9-8090cc7d74cd@linux.ibm.com>
         <CSCLXUWIMPCG.D6K372YA1HMK@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-05-03 at 14:31 +0300, Jarkko Sakkinen wrote:
> On Tue May 2, 2023 at 5:09 PM EEST, Stefan Berger wrote:
> > 
> > 
> > On 4/3/23 17:39, James Bottomley wrote:
> > > Introducing encryption sessions changes where the return
> > > parameters
> 
> s/Introducing/Introduce/
> 
> Commit messages should always be in the imperative form.

"Introducing" in this sentence is a gerund (verb used as a noun); it
can't be changed to an imperative because it's not being used as a
direct verb in the sentence (that honour goes to "changes", which also
can't be made imperative because the gerund is the subject).  I can
reword it like this if you want the sentence to begin with an
imperative (and get rid of the gerund before Linus bites my head off
again for using obscure grammatical constructions):

"Replace all instances of &buf.data[TPM_HEADER_SIZE] with a new
function tpm_buf_parameters() because encryption sessions change
where the return parameters are located in the buffer since if a
return session is present they're 4 bytes beyond the header with those
4 bytes giving the parameter length.  If there is no return session,
then they're in the usual place immediately after the header."

James


