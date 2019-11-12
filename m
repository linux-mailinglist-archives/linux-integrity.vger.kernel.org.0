Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B67F871C
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 04:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLDgn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 22:36:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35593 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726910AbfKLDgn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 22:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573529802;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aCpQt1ZhYboSDvHFUTsiD3XPm9kOvrjtHzxUZdWKqsM=;
        b=K/rqUcqwyofOSjH1rymlbMpyCbJqM9nLxr1QsSMNxDy1ygZr4zQVzMvx0e+4S1WZ8KgS7E
        DJ37TLoFRttOPVRtqGK0kpZyhhsqaiS57roRByH6jJZgdMb+KHi52QDVQDy4g7XQQ1Y+P+
        ZA7IFvDfpInv4A0YN1wCgNTbgBWiIqg=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-0CP6PY0_Nb-m0_JVRM-a2Q-1; Mon, 11 Nov 2019 22:36:41 -0500
Received: by mail-yw1-f69.google.com with SMTP id h13so11166146ywc.20
        for <linux-integrity@vger.kernel.org>; Mon, 11 Nov 2019 19:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:mime-version:content-disposition;
        bh=/1ARDGGQ15uF46oAOzdoibrj2QJIiMCSuS05wL1ErLI=;
        b=oIf/CpYxhk91F9e/kU52lD+q5JyVG8XHRpPvdGZCEIcnCWKPvYoYdrKs3AzeTdbaJ3
         /QUil33K9bke3QxbWMZgO/h4spGUhzAC9OHI7P4Itczlupt6nCUQFaPvgGjtNvfxQhnT
         qaOaMk1m+IoeFia+imSrmCGNqjT69qhd3dZwYT07OLjWoindrGWYZ7iM9QnAr59hSW51
         VYdNeR8c1ji+eJDlGTxv+eryMvvrsfov1x9V0Aa5e54Cf2MtQ/1MUba5YQNwrosQc2Ai
         dNUqzk/w2tldEmgEXjqvuGemqQWK5Jwk19golC3fDEIozXXwpsVobrD6e/qgqj9kNya7
         V98Q==
X-Gm-Message-State: APjAAAVED5Jcsm468UW+jgV/Vuz0ca0FFetHlK8c+W6CFbYLfKIYGZRz
        xXzupQSRLb7mdtlpqMFRnoSSRznZvBW2v3wGmVjHVsYiygN1YjJHYQd0RqWRA3UQKoH3u4AuAtj
        6Mu5rA0F7jSSSvYmQDxJi2+Re8kpa
X-Received: by 2002:a0d:d307:: with SMTP id v7mr18393616ywd.300.1573529800611;
        Mon, 11 Nov 2019 19:36:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnrgVNvPYNQ7lJLTh7ZbIVCVDYyBwENVzJc7NGixTK7eawM2Npsto2yMtqFwJCUQe+vAiNPQ==
X-Received: by 2002:a0d:d307:: with SMTP id v7mr18393605ywd.300.1573529800280;
        Mon, 11 Nov 2019 19:36:40 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x78sm7369131ywg.108.2019.11.11.19.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 19:36:39 -0800 (PST)
Date:   Mon, 11 Nov 2019 20:36:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112033637.kxotlhm6mtr5irvd@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-MC-Unique: 0CP6PY0_Nb-m0_JVRM-a2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before pr=
obing for interrupts").
Doesn't tpm_tis_send set this flag, and setting it here in tpm_tis_core_ini=
t short circuits what
tpm_tis_send was doing before? There is a bug report of an interrupt storm =
from a tpm on a t490s laptop
with the Fedora 31 kernel (5.3), and I'm wondering if this change could cau=
se that. Before they got
the warning about interrupts not working, and using polling instead.

