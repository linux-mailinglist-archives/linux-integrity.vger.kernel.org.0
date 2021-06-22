Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072973B0727
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFVOPi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 10:15:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37594 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhFVOPh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 10:15:37 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2AA43218F7;
        Tue, 22 Jun 2021 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iE66dGKEbpgzne2/5eLIma+0BBmr1TxYMlJqibYDLUc=;
        b=jEQvN+Q4NrzRWTSkLUy8qeYwaLfBFT8IYcURZ/gdjJE3EMJjk60CGFxfCvjDLcNWp4Bju9
        ynbNUqYSNhOZmUS33g88kneFYadVL1YdKISlhIrAtJPMFaSKtSeQZ9lUXRfhejwA3WX52u
        yXvTXyKVoEnl5u+UdEytoe/bxqddmbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iE66dGKEbpgzne2/5eLIma+0BBmr1TxYMlJqibYDLUc=;
        b=IHSju7B4yrMSCj755PdSK+pg83rKu6l9gXGnf4tpI9ak6XRmemkYwgD7us437eeHQdw/9f
        0AubhLieLrnrISBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EE2A2118DD;
        Tue, 22 Jun 2021 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iE66dGKEbpgzne2/5eLIma+0BBmr1TxYMlJqibYDLUc=;
        b=jEQvN+Q4NrzRWTSkLUy8qeYwaLfBFT8IYcURZ/gdjJE3EMJjk60CGFxfCvjDLcNWp4Bju9
        ynbNUqYSNhOZmUS33g88kneFYadVL1YdKISlhIrAtJPMFaSKtSeQZ9lUXRfhejwA3WX52u
        yXvTXyKVoEnl5u+UdEytoe/bxqddmbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iE66dGKEbpgzne2/5eLIma+0BBmr1TxYMlJqibYDLUc=;
        b=IHSju7B4yrMSCj755PdSK+pg83rKu6l9gXGnf4tpI9ak6XRmemkYwgD7us437eeHQdw/9f
        0AubhLieLrnrISBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id exlWOADw0WDQUgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 22 Jun 2021 14:13:20 +0000
Date:   Tue, 22 Jun 2021 16:13:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Add GitHub Actions support
Message-ID: <YNHv/oTp7/8rH7sc@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210622141224.25006-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622141224.25006-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Tested: https://github.com/pevik/ima-evm-utils/actions/runs/960841012

Kind regards,
Petr
