Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E54E58F6
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Mar 2022 20:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiCWTOx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCWTOx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 15:14:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C626541
        for <linux-integrity@vger.kernel.org>; Wed, 23 Mar 2022 12:13:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FAC3210F6;
        Wed, 23 Mar 2022 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648062798;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qy5rovrWeH5MKY2iGwrGdNPImDXcDkEinEYbDk9EM7Q=;
        b=oyE8VPCDrif3uIhyiQGPitnXU1UAMzNvT0mTwibCnsvRad+qDLY6qeLjEEqMYAbKffEu7r
        lps2XiY0nxMnR8cahAmaCfyMOtRsgO4S7n3y3YAHluUKurdzq12CVYHRsPQO6+3N351IMi
        rtQ8C9r6GVAegLjCnmQTknA7MR/K1JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648062798;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qy5rovrWeH5MKY2iGwrGdNPImDXcDkEinEYbDk9EM7Q=;
        b=8cCIkESw0OyslUBBinNy4d6MdtwhxwU9qzF2BLt3sgGkbM0Y3/HbDcCbvS0vBfIenzIRen
        B6WoT0+b7h0eoxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ABF413302;
        Wed, 23 Mar 2022 19:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9dkTGE5xO2JuSgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 19:13:18 +0000
Date:   Wed, 23 Mar 2022 20:13:16 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YjtxTJX91bwftEne@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220223200731.1859670-1-yaelt@google.com>
 <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik>
 <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik>
 <YiDGvzETiI/nxwW/@yuki>
 <YiDLn3GMNFu482XG@pevik>
 <CAKoutNsc-JWQd1MOTFk7Hd_MgsFKj=6qi=uusKez2HgatTNCdQ@mail.gmail.com>
 <YjOcRn1qx0LHlO/j@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjOcRn1qx0LHlO/j@pevik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> > Hi Petr and Cyril,

> > I wanted to check whether there is pending action left on my end?
> @Yael nothing needed from you.

> @Cyril cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data") is in Mimi Zohar's git tree and in next tree, going to be
> merged in next merge window. Can we merge it now as is?

@Cyril cd3bc044af48 is in the next tree. Are we going to wait till it reaches
Linus' tree (in 5.18-rc1) or can I merge it now?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220323&id=cd3bc044af483422cc81a93f23c78c20c978b17c

Kind regards,
Petr

> Kind regards,
> Petr
