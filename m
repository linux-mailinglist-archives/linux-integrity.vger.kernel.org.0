Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D823C2788
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIQa6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 12:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIQa5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 12:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 698A361209;
        Fri,  9 Jul 2021 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625848094;
        bh=RwviPM07Qe2nCRpEFtpWX6FjU+ANwP8piVW/VuJM5qw=;
        h=Date:From:To:From;
        b=kfCCjhPx+yiUn/hwxLXRc8I4NDiWtuFd7mH/PoLI8+W1+Q4iCqIEnbg/HLD9wxo8Y
         Fl91BiNN9m4DSzTc+a2Zes3ulAUHHGuDTdica7MrmvHik/lFpek5hAjkmyDfzyqiO+
         +FXDm8tenvoLYlx7w0yY0JHNzqUpbo0ftSg28C2FW044lP8zKRBSnhox6AAEgV3Y36
         niTE95SUE0ZrXuvp1zho092iOEDZBJKReMwwuF5Non2vosIu+NDdQOtnTFMjH7LDdy
         kBbx+RnROpbOuz8foDDFEBwbrp57nYGTSJa8BsmTln0AggCpQ+awSwYEVNwJTsvH5O
         u2R3S1tvd2ptg==
Date:   Fri, 9 Jul 2021 19:28:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org, linux-integrity@vger.kernel.org
Message-ID: <20210709162811.46crtmbzvbl6xh3n@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm on leave two upcoming weeks: 28 and 29. Expect slow response but
I'll check LKML at minimum once a week.

/Jarkko
