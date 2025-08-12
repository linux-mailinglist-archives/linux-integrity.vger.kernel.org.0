Return-Path: <linux-integrity+bounces-6798-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005BB227C2
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 15:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0545A68109A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF9270ED7;
	Tue, 12 Aug 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX526Aho"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654B26D4EB;
	Tue, 12 Aug 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003569; cv=none; b=sTp6E0/aj3HJnwv5SxKeRqNkvWOnMtXWIxZgpRtZKAg1UO7BoR6SHnnAtFY9l9TRQV4wLW+vDbmmtjvpMBLfStzd9yXU/CZnz263SwKeJAFY4TVQhPYMV2d1YI+wOdne4CahTlM8UdnzsO2arG0IVZz2LQu+klBSmNZrZ3v3amQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003569; c=relaxed/simple;
	bh=RZ5vAmJOYVLCS14bnkVli5Uta59ZRHvEqdzwAnsg0y0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j6hYia75hT7fLIOENOCg1jid4wDey1xdrTac1Li5Mshu3KQdFkpY50sKAs0zjJ+LbXlHExoUWNqDZIjUgSw7FhHKK9Ie495kh0K7bR9y53eY0EW2i0vpV52aL9V1k2dOpUmBzxRMUsmQyjXTTutOkJ99WhVxLJbC8w40oEYmhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX526Aho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBF7C4CEF0;
	Tue, 12 Aug 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003569;
	bh=RZ5vAmJOYVLCS14bnkVli5Uta59ZRHvEqdzwAnsg0y0=;
	h=Date:From:To:Subject:From;
	b=nX526AhoiX6elZGKSBGuOGpaLgak/3OjIduyWkF3skZdeg8KfM04ZxMJ41peZd/ZY
	 9Gad/pXO7qXXrG4OvkavyerV9l+ls79yUDcPszwIZlEpPcBKxV4EdFz36HRLDpSKbK
	 zJFyWSopOIYTaRQgZ8CF2MGQ8/1KWaYbRI2F3noxGzfMmEX+TZYmOEGU0ARkW7yeAl
	 0EJGn4/6yZc+2Jlw/w8xELBt7A/j5hZ+qPKmFNSG0jPg3RbtUo2bEIg5mcUEmDQpbA
	 8c9zIteTIGn5ETtIki+kHBGtoUfCRSTWjye+gULQEOYHow6qR3ZiBkt1OWCTHuME4z
	 TRy1bPvOKDU/Q==
Date: Tue, 12 Aug 2025 15:59:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: tpm2_protocol
Message-ID: <aJs6rWexGNsH45_Z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I came up with this within 1,5 weeks not much sleep, and thought that
this might be interesting to all of the three lists:

tpm_struct!(
    #[derive(Debug, PartialEq, Eq, Clone)]
    TpmPcrEventCommand,
    TpmCc::PcrEvent,
    TpmSt::Sessions,
    1,
    {
        pub event_data: Tpm2b,
    }
);

tpm_response!(
    #[derive(Debug, Default, PartialEq, Eq, Clone)]
    TpmPcrEventResponse,
    TpmCc::PcrEvent,
    TpmSt::Sessions,
    {
        pub digests: TpmlDigestValues,
    }
);

[tpm_struct is also used for data types, it so just happend that it
equally works for commands, every single type in depth shares the
same core marshalling and unmarshalling infrastructure]

It's a zero deps, no-alloc and no_st crate which unamrshals the full TCG
specification to both directions. I.e. you can build a TPM emulator
alike thing  "in a day", and not just interface with a chip.  As it runs
also on bare-metal (it's a stack allocated entity), it would scale even
to chip firmware.

I targeted this for Linux kernel, and thus the design choices. I just
thought what would be the part that would trigger me most if someone
submitted a Rust driver, and implemented it myself. Learning from what
I've seen basically :-) I totally support someone making a Rust driver
and I thought this in-depth understanding of the protocol is my best
possible contribution for such effort (binding IO shenanigans not so
much).  E.g. you could use this to do a way better /dev/tpmrm0 than what
exists today with high-fidelity filtering and shit.

Obviously I hope to be a co-maintainer if such thing ever happens.

Since it is also independent crate it can be e.g., used to build
interoperability layers and stuff like that.

There's also a cli called simply "tpm2". I'll probably make it alll
available today or tomorrow.

BR, Jarkko

