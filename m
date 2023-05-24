Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9168470EAC0
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 03:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbjEXB1i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 21:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjEXB1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 21:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74FE5;
        Tue, 23 May 2023 18:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561336335A;
        Wed, 24 May 2023 01:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E5AC433D2;
        Wed, 24 May 2023 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684891655;
        bh=+WcFC3ZuBzCMetAlFyxcdTIwCfk0qpdjVDSSvtNKS3M=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=nmPqrTziLWzeDSATIBbVYaSRpqJm5R5V5zJ5gdXOH/10p7Zk4GHv+v6YYM8eNQYAl
         HpS4IdhrCQoNjOxp9ccPy13BPzPC7a82Btszq0X0ugEmPc96q9kJx2HpWN1C85icID
         0EAzBih2mD0AhZQ542Ix0b4Poxtv325UFDx9KhDgoeQO3ir/JLH9AxVSmtop97eOr3
         BhW6C4zJLuo/QaxSAgdtZU9Ki8fywfKDeC9A0PMIRSvrCc8gMU6tVH/U7ZyCVXGWmF
         W0IobLGj2N9PznD1qozRNTngHXBCNHKp5x8FBjhAGsruZOB5Cf7I/DcAaexQemYP9X
         s550Im4AvkCSA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 04:27:30 +0300
Message-Id: <CSU48QNPCXL4.1WBHVCECJ2PZU@suppilovahvero>
Cc:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <jlee@suse.com>,
        <kanth.ghatraju@oracle.com>, <konrad.wilk@oracle.com>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] integrity: Enforce digitalSignature usage in the
 ima and evm keyrings
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
 <20230522230944.180389-3-eric.snowberg@oracle.com>
 <ce525793452831d5823bf0548faa0eae2a302f5a.camel@linux.ibm.com>
 <CSU44RXD19SU.26AGW4IZDW9CK@suppilovahvero>
In-Reply-To: <CSU44RXD19SU.26AGW4IZDW9CK@suppilovahvero>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 4:22 AM EEST, Jarkko Sakkinen wrote:
> On Wed May 24, 2023 at 1:01 AM EEST, Mimi Zohar wrote:
> > On Mon, 2023-05-22 at 19:09 -0400, Eric Snowberg wrote:
> > > After being vouched for by a system keyring, only allow keys into the=
 .ima
> > > and .evm keyrings that have the digitalSignature usage field set.
> > >=20
> > > Link: https://lore.kernel.org/all/41dffdaeb7eb7840f7e38bc691fbda83663=
5c9f9.camel@linux.ibm.com
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> >
> > Jarrko, similarly please update the above tag to Acked-and-test-by.
>
> OK, cool, I'll pick this series, thanks.

Please check https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-t=
pmdd.git

BR, Jarkko
