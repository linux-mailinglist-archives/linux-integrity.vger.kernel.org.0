Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0FD3DD429
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Aug 2021 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhHBKp1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Aug 2021 06:45:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:26500 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhHBKpZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Aug 2021 06:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627901109;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0C41dY/n6aw22V+v0ycfpnD70EcxfX5rn3a209ngQAA=;
    b=A7jYVDzTaLWMP7DQ3QVgrTxXFYie1me3v28jaBy8/z4vv1v2dWC653+MvYXrpNF31X
    ZDw6e7TXpenyWE/PVX9nN65rNxS42h28IQSFaGOYiGu0BTk/Z4T8X5hBJ5fKhhA+iwu3
    icUpsUzPW15VWlgBkX8Sac8JW716X2IVSzPLWVD0ukp5FDa++2HEWR8+YQpo7dJnBCjh
    C77rAgt38F/GJMyLnUHdPxpTGtxfMUo7O2SZgvojc8+b6eFis9JuledG0ECFBiu5/FWc
    GJ/WnHb4HHgCazdDtDL0Eo+phc3FPyz+WvqKLSsw3MkOZHKdbj26ZEocSL/fgAEopvAf
    48tw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id t06ddcx72Aj98Re
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 Aug 2021 12:45:09 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     agk@redhat.com
Cc:     dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, public@thson.de, snitzer@redhat.com,
        tusharsu@linux.microsoft.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using IMA
Date:   Mon,  2 Aug 2021 12:45:00 +0200
Message-Id: <20210802104500.199787-1-public@thson.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210728213350.GA115575@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
References: <20210728213350.GA115575@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alasdair,

thank you for the explanation and pointing me into the right direction.  
I was wondering how we can differentiate the different devices in the remote
attestation service and now I think that I understand the format of the uuids,
so that we can implement a parser/validator for that.

Regards,
Thore
