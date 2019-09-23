Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC42BBA2D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2019 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbfIWRKQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Sep 2019 13:10:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22124 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732903AbfIWRKP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Sep 2019 13:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569258614;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brtnUNEATJxaiEmZJMG7ZyzZu+Ldb+R0Iih2eWtZNa8=;
        b=CvIurzkUgXXwWaeRZFHy9j301sh+XRjQ129axRbcz3vxYFAltnTcG+DS10099kKtvNAnWm
        hyAZ0mDMFjBhAqdZoio/LZFJNydHiaBpDSKBNHQiHt3PEbZOizDET2hG4HOPPjkOXrVTiB
        ZeymYIv3TDz4WM1/u9bTNwcvWatQKUI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-pE-UcHyjOzSPKSVDyWk9EQ-1; Mon, 23 Sep 2019 13:10:13 -0400
Received: by mail-io1-f71.google.com with SMTP id r13so24416588ioj.22
        for <linux-integrity@vger.kernel.org>; Mon, 23 Sep 2019 10:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rh1uvaNsooagBW4WOK11wp/OzNbWIxJmJoNftck7Ang=;
        b=dbP5LtaUs8HIdH3YwENEHo/ZdjQ6uQjO8YsTTjHOv+XKjP2SaxRmjZkimJrGFJ2pot
         hhUZml6X9zDlOSeMCGFG9mOeLMX+gI6Lorc1A67Ug3X81WrO8I4SDDrqf7//bs9ca6B5
         AXDpbZ0bK+6yCU1/11fr6xBtLCJfFws+N6XNsz4JL9N3N5W4rkrcVVKxVsD01njywhxI
         5GGuhKCTYCAejFF8HxOPyfg0vb2zmIZW9Eag4UX2Scj4j0Ev3eNGktzKFW8PDMC4HT+V
         ult59AAHz5EdA3D0dq5dqinZpNQBOQRktyz8OQ475LZoiyrQpJKOtpuFwhdX/75rUJQ+
         9g8A==
X-Gm-Message-State: APjAAAUJFTEDpBk5YiMw9oUeM4XeTmc8DX0PbRSoqzhMRP4Kwt8HokoZ
        I53ZFH/rn9BcguKToJPomIqUjcodCUtyuP8uZfb6AztQFk7uc6UVqHdl/B3KJYRAqsGWLQpm7jF
        vhGH0+gYANnUG9RVZNpyBQJzqsmHN
X-Received: by 2002:a5e:9917:: with SMTP id t23mr308423ioj.141.1569258612795;
        Mon, 23 Sep 2019 10:10:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXT9PS2Bv55kiYnVhChrkQQVSNPJh291rae4rfNmJB3BZ6AEfm4CLIiEf4j7x0kpdjPLYidA==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr308405ioj.141.1569258612538;
        Mon, 23 Sep 2019 10:10:12 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id w7sm11707131iob.17.2019.09.23.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 10:10:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:10:10 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [RFC PATCH] tpm: only set efi_tpm_final_log_size after
 successful event log parsing
Message-ID: <20190923171010.csz4js3xs2mixmpq@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20190918191626.5741-1-jsnitsel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190918191626.5741-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: pE-UcHyjOzSPKSVDyWk9EQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Any thoughts on this? I know of at least 2 Lenovo models that are
running into this problem.

In the case of the one I have currently have access to the problem is
that the hash algorithm id for an event isn't one that is currently in
the TCG registry, and it fails to find a match when walking the
digest_sizes array. That seems like an issue for the vendor to fix in the b=
ios,
but we should look at the return value of tpm2_calc_event_log_size and not
stick a negative value in efi_tpm_final_log_size.

