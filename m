Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE73DD3F9
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Aug 2021 12:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhHBKis (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Aug 2021 06:38:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:30015 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhHBKis (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Aug 2021 06:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627900712;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DIP3I6RkjVHsVygWJupDRROPDy4l0f131Hll/tYq4Es=;
    b=f+rxEr7fnFTMped9cXehWX+Eyqk6kARXB2fN2XMDyqFNSH6VfXbSNlRUyN3yeJ2HQJ
    ODO7LIrOZ0sRZUKhjfk6uRIM7XG4AmCskDZTDKAnlUUB3LdCGaYmv8yjmscHc99We1rn
    eVKj98ljQ1bkKR8BHTuXMHl32bbWsqAzemJcPlYhkUfxvJMinLIuHzFxuWPk1KI9hkzt
    yOOnuU/KBDXRIFwEiGs6zuW/eIVyuBDim72dgdpiRULAPK+1gDYjHU1AO7NPuAbYzOVm
    STB5O0nfmgjbHKbpG+nCD107+03vb19KBnrhm7W5mRL18eoitUIYgZkYm8uGAosTVlSu
    pPBw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id t06ddcx72AcW8Oj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 Aug 2021 12:38:32 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     tusharsu@linux.microsoft.com
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        public@thson.de, snitzer@redhat.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using IMA
Date:   Mon,  2 Aug 2021 12:38:23 +0200
Message-Id: <20210802103823.199091-1-public@thson.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <f73308f3-485f-46cb-0f20-6619edb541e6@linux.microsoft.com>
References: <f73308f3-485f-46cb-0f20-6619edb541e6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

thank you for answering my questions and looking at my suggestions.

> I can update the verity_status() to measure if v->signature_key_desc is 
> set.
> 
> Something like:
> DMEMIT("signature_key_desc_present=%c,", v->signature_key_desc ? 'y' :
> 'n');

If my understanding that this entry is only set if the signature was validated
is correct then this should work.

> Please note – even if we measure signature_key_desc (full string or just
> its presence): in order to use it with the keyrings, the IMA policy also
> needs to be set to measure key rings (using "measure func=KEY_CHECK
> ..."). It is independent from measuring the device mapper data (which is
> measured when the policy is set to “measure func=CRITICAL_DATA
> label=device-mapper ...").
> 
> Therefore measuring keyrings together (i.e. in the same IMA log) with DM
> data  is not always guaranteed, since it is dictated by how the IMA
> policy is configured.

Thanks for pointing that out. Currently we don't measure the keyrings but when
we enable remote attestation for dm-verity we'll make sure that our IMA policy
also measures the keyrings.

Regards,
Thore
