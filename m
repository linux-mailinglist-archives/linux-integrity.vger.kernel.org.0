Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B294320281
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBTBdr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTBdr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:33:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01DC061574
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so8812378ybk.9
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6CYx/dMpUWhnaBhgXdOPJQFkQW+qYUUCxUHvQTIq/hw=;
        b=F40eCNyvGJc0EnWR9ZPNcaYJMoCL0Z1saoI2XaNbsnmwP78mHNMnyjTc1ydkyON2zF
         ACwEAk/BdSP0YuTuiKIIbhg22F2lsxITzu+WCi1SlhmrbxZngG/GX75loKzPncte2Eko
         dAJ3iM3U2LWh9fYNTMf3YlRj7bQ3sr7crqO9TpBM6sa3ErHEkGd0z24i/RZpllfGu3EH
         Y5TmoQh/opXSNzp7T44EpPnhsmHpqAijsGWy55sD1E5GOq7B8OmLc4LJjgcGgvZUucze
         CTtR6x47ChPomKsp/E/L3+fjvKs8bul6A9j0CwH6g/BJ1+wAgxlNop2MCKHBgxERpFku
         C05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6CYx/dMpUWhnaBhgXdOPJQFkQW+qYUUCxUHvQTIq/hw=;
        b=SpgeDQlabr+do/X3PJx7KIP4yU49L+GlmTsWxymOOQ1DBlbcHpHEpd7X7nVsgNJr+V
         vM1+Q8YUo4fVrZK8poL4BzAfEEQnEBNOTcidz/dvQlvzY4pAVC/prd33B8obSNjDFcB9
         2GbfYjEqmcSEnMR6k2nn5u/JeLQd0uQlHvKnPRZddh92rvsSL+8qOn0j4wA4djrAFxqy
         FMHxsBNKY/6yyKw2fZ9JvKSsZFjpAh3p3et1Y8wp4g4X8rD+sh6jZQEJzM6Nfx92kOYi
         xd/pY1qIu9e65yyQE9XKm0FG2I1LkjrksZhKmbf9u8O4jZlFdb0s5b0yr36AZv3UWvq4
         KfyQ==
X-Gm-Message-State: AOAM5315WAoHcSyOVA8XefaK5f7gXyKuAp7gx8ZxNnd7L5GE+Ie3WAJh
        l3Nfn5UQJe4Lf3W1iFXj6E7qumO2QV2sYMsNn9VNdA==
X-Google-Smtp-Source: ABdhPJzUYzQX0oV7fl/lX8syZusalWetijMpmHVZ6iK56cekzBl+wjZ5xZyakjq+gp2/VuCmYC5MLuf8YeNX8AsC7o1luw==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a25:7d84:: with SMTP id
 y126mr17691890ybc.179.1613784786198; Fri, 19 Feb 2021 17:33:06 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:46 +0000
Message-Id: <20210220013255.1083202-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 0/9] Enable hibernation when Lockdown is enabled
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Lockdown in integrity mode aims to ensure that arbitrary code cannot end
up in ring 0 without owner approval. The combination of module signing
and secure boot gets most of the way there, but various other features
are disabled by lockdown in order to avoid more convoluted approaches
that would enable unwanted code to end up in kernel space. One of these
is hibernation, since at present the kernel performs no verification of
the code it's resuming. If hibernation were permitted, an attacker with
root (but not kernel) privileges could disable swap, write a valid
hibernation image containing code of their own choosing to the swap
partition, and then reboot. On reboot, the kernel would happily resume
the provided code.

This patchset aims to provide a secure implementation of hibernation. It
is based on the presumption that simply storing a key in-kernel is
insufficient, since if Lockdown is merely in integrity (rather than
confidentiality) mode we assume that root is able to read kernel memory
and so would be able to obtain these secrets. It also aims to be
unspoofable - an attacker should not be able to write out a hibernation
image using cryptographic material under their control.

TPMs can be used to generate key material that is encrypted with a key
that does not leave the TPM. This means that we can generate an AES key,
encrypt the image hash with it, encrypt it with a TPM-backed key, and store
the encrypted key in the hibernation image. On resume, we pass the key
back to the TPM, receive the unencrypted AES key, and use that to
validate the image.

However, this is insufficient. Nothing prevents anyone else with access
to the TPM asking it to decrypt the key. We need to be able to
distinguish between accesses that come from the kernel directly and
accesses that come from userland.

TPMs have several Platform Configuration Registers (PCRs) which are used
for different purposes. PCRs are initialised to a known value, and
cannot be modified directly by the platform. Instead, the platform can
provide a hash of some data to the TPM. The TPM combines the existing
PCR value with the new hash, and stores the hash of this combination in
the PCR. Most PCRs can only be extended, which means that the only way
to achieve a specific value for a TPM is to perform the same series of
writes.

When secrets are encrypted by the TPM, they can be accompanied by a
policy that describes the state the TPM must be in in order for it to
decrypt them. If the TPM is not in this state, it will refuse to decrypt
the material even if it is otherwise capable of doing so. This allows
keys to be tied to specific system state - if the system is not in that
state, the TPM will not grant access.

PCR 23 is special in that it can be reset on demand. This patchset
re-purposes PCR 23 and blocks userland's ability to extend or reset it.
The kernel is then free to impose policy by resetting PCR 23 to a known
starting point, extending it with a known value, encrypting key material
with a policy that ties it to PCR 23, and then resetting it. Even if
userland has access to the encrypted blob, it cannot decrypt it since it
has no way to force PCR 23 to be in the same state.

So. During hibernation we freeze userland. We then reset PCR 23 and
extend it to a known value. We generate a key, use it and then encrypt
it with the TPM. When we encrypt it, we define a policy which states
that the TPM must have the same PCR 23 value as it presently does. We
also store the current PCR 23 value in the key metadata. On resume, we
again freeze userland, reset PCR 23 and extend it to the same value. We
decrypt the key, and verify from the metadata that it was created when
PCR 23 had the expected value. If so, we use it to decrypt the hash used
to verify the hibernation image and ensure that the image matches it. If
everything looks good, we resume. If not, we return to userland. Either
way, we reset PCR 23 before any userland code runs again.

This all works on my machine, but it's imperfect - there's a meaningful
performance hit on resume forced by reading all the blocks in-order, and
it probably makes more sense to do that after reads are complete instead
but I wanted to get the other components of this out for review first.
It's also not ideal from a security perspective until there's more
ecosystem integration - we need a kernel to be able to assert to a
signed bootloader that it implements this, since otherwise an attacker
can simply downgrade to a kernel that doesn't implement this policy and
gain access to PCR 23 themselves. There's ongoing work in the UEFI
bootloader space that would make this possible.


