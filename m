Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468E47E16FA
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Nov 2023 22:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjKEV7L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Nov 2023 16:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKEV7K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Nov 2023 16:59:10 -0500
X-Greylist: delayed 5133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 13:59:07 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E795FCC;
        Sun,  5 Nov 2023 13:59:07 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 5AAE4193AD;
        Mon,  6 Nov 2023 01:57:54 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 53713192C1;
        Mon,  6 Nov 2023 01:57:54 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id E571A1B81FC6;
        Mon,  6 Nov 2023 01:57:55 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nxoECyIIl_YQ; Mon,  6 Nov 2023 01:57:55 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id B33E61B8250D;
        Mon,  6 Nov 2023 01:57:55 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn B33E61B8250D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210675;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=X6QE+5M7khQ7q+G08Vtcahzk6t4Lj1RcMkQg3wucxsfaW94u2OpQHftgWFcQw4rbl
         QwNqKG5AnctuKXHodCBi3nl8xbI7IKsSMsCIE90aPBT/MO+JPibKFnwpeGCWtD0m5P
         x4djqZC60wHL0zOKeNYuUE6f/QMWVy7c6mAfYIMJ80Qv4fZZ/nCAhMJn7of7xQDyO4
         FdSys5l92ul7K1Am7VXcDGwYdDDF0dv+/UkFuid/j4MdHq6c/6cSsvo4Y2PuMTrH39
         d1r2TY9nSCmhZMU+IDQj9rf0prNArxmTa8QnhUlfHzhHxEh+g+3pUdaDl2ZeED/J2G
         7u6wEBIZnihjg==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VYyKrE7ui0pf; Mon,  6 Nov 2023 01:57:55 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 54C3D1B81FC6;
        Mon,  6 Nov 2023 01:57:49 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:38 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185749.54C3D1B81FC6@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

