Return-Path: <linux-integrity+bounces-6583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC9AF6352
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB891885309
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C442DE71E;
	Wed,  2 Jul 2025 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHCvhg7s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942D1C1F12
	for <linux-integrity@vger.kernel.org>; Wed,  2 Jul 2025 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488140; cv=none; b=KlhKAL3M+wrSp0LP7ckCC5FKSVMQfScErhZbSIG9SCtzID7UnAWVwLEFS2iTIRCDQSg2g1inrWF+o5dIU8bVr0miEUVQqxwElW5gYPTNIzANOsnX6dL11+T5hXhFirPXn0MK1GMFab9cL+BlL+SL+oVJJivjr/AAUEsLiXSsHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488140; c=relaxed/simple;
	bh=Z+8+o7E9FsUdbR0qGHtdZso7wtng2PNvnJ2nJmhhRlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxMQ6z+CAF7neLkDYZPpR1sRRFfeXNffNJVD9fUVkJeUFU2WH16Yz+Z7+PuXeG+VWUo24D3zSvRig8vFgB44GCIFd44ESqhwDn4ohqoiIGdl7X5DiMNONJz/kJYd0z95lH/TdxRtgKWuI/Y2wX+40HQj5a1i9AWMNkqJfAdNJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHCvhg7s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751488137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UT8T665UTTveBTA8Fo0NAEBN2xUQCc2LvkRF4QTZEq0=;
	b=jHCvhg7s/LO0Mx2n1GWsGlJFZyV3F0cr3NHI+EZB3+FjqTeoIOAw+9Q5vfamDtNwy8aazc
	koMel97gEthwSM8zGdjkaagcu2I0ayBhQMQiz3SncviQ2o9aCsELkHGv8q2uOXfGgHRE9z
	K0oiAfnVjDYxpvvitXnbjekaZbKsmKA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-FqsJ5l2dM6GRwuesb041TA-1; Wed, 02 Jul 2025 16:28:56 -0400
X-MC-Unique: FqsJ5l2dM6GRwuesb041TA-1
X-Mimecast-MFC-AGG-ID: FqsJ5l2dM6GRwuesb041TA_1751488136
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a823b5320cso56652871cf.0
        for <linux-integrity@vger.kernel.org>; Wed, 02 Jul 2025 13:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488136; x=1752092936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT8T665UTTveBTA8Fo0NAEBN2xUQCc2LvkRF4QTZEq0=;
        b=xLsg6cLX7DY19kIVBkAQ93AqIF4hysDhcqOxokZYSDULgc+GSWGzWo+CjJ8GUhb+YD
         k6jzmLeGmAWsB0EIaYGuVJwAWo/5+WunMx2HZh6rQGQs9sjU/I/rpz0L4jJxXTqBOUWf
         VOXsBfI9kYNMvIsRvibVvyH9e13LN89ufXi94GzHkUxplL51ZEuPdIESWLjXBUoSl3IF
         9J8hoaPhqgE4l9a3AxMezTqCv1BYD4PdvO3/azgaQHxadOcXEW5NrPWhZWfBt+BJHsYH
         a3WVH3EI5I2pbVR7IprP+PtV9TENkjBXYAF0xpOf75srimzIs32wFVzGB328ITf0apTF
         y61A==
X-Forwarded-Encrypted: i=1; AJvYcCUZkFlmX+zK3XdcCvD0Yoyuo9E/wbi7JXDi6qdJCbuX/xIHUdgD4H6w6s8pYHIbfpjMijbdDM2H88jqdzeZPi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLg5Mxi40xeXmtIJ/90Wfab47is6MZIV0GqYeJpskeWn9AHWN
	ZEPTnRjGuawTYu3fdUJKije3+uUaX6wvxF8VBFDaKsqhYiP3TI8jk5rrXGtc8MdN7I3NbvpXBT/
	7ydQt1ChqTc28y4orxlX+5BB6VCxvbF5XLumiDgLhaHAp/5sqZiiAnJYCqELgmiAIcCt8Rw==
X-Gm-Gg: ASbGncvxlD576YUf7FnVuVKPKR7k/mSluj1GsMhesSuAr+NeuBeUnl4g2F8hV2aBbxv
	Rr22Ab2IbOnWzwPZ2MENYxDAguedJsr9SVuov0sZFgbwjYFUb/yhsz4DyfZwio+EUIXv7O9DXBC
	YSkRnAX8z+xhz22Uwtf16g3jTdWaEmancTEb3fet2g6kVTPCazUaoGYaV6pr8A/s+43ImJor6n1
	zfqZFmxOjJwn3xnVxgLuCs1P13VfjDYxBmNQkqu/2/M7CoJMSGzBOQ92kjSREVwT4XXj3zMYjm2
	qI7fwWBCAOk68WFLZtmNohm08TQHwWH8gqDD08vT3Upqw7p7Bu9RkjM=
X-Received: by 2002:a05:622a:2c5:b0:4a3:fcc7:c73c with SMTP id d75a77b69052e-4a98796ac11mr12318791cf.8.1751488135704;
        Wed, 02 Jul 2025 13:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEowkrYDNh1f8UR4Edcldpooh92BuqBWo9qQdkerGzX6FXDPIT0L+uWqI0YasteTTu/p2Q3rA==
X-Received: by 2002:a05:622a:2c5:b0:4a3:fcc7:c73c with SMTP id d75a77b69052e-4a98796ac11mr12318351cf.8.1751488135245;
        Wed, 02 Jul 2025 13:28:55 -0700 (PDT)
Received: from daleksan-thinkpadp1gen3.boston.csb ([2601:19b:4186:1bc0:780a:22af:8f37:f438])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc10bec2sm96732301cf.13.2025.07.02.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:28:54 -0700 (PDT)
From: Denis Aleksandrov <daleksan@redhat.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Denis Aleksandrov <daleksan@redhat.com>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Date: Wed,  2 Jul 2025 16:28:51 -0400
Message-ID: <20250702202851.33344-1-daleksan@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug is not seen on most machines. Reads on tpm/tpm0/ppi/*operations
can become very long on misconfigured systems. Reading the TPM is a
blocking operation, thus a user could effectively trigger a DOS.

Resolve this by restricting unprivileged user from reading the
above-mentioned device files.

Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
---

Running scripts/checkpatch.pl suggested that the permissions be
changed to octal format. What do the maintainers think of this?
The rest of the permissions in the file are macros.

Lastly, this bug was reproduced and the fix was tested accordingly.

 drivers/char/tpm/tpm_ppi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index bc7b1b4501b3..ac6e0aee566e 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -347,8 +347,8 @@ static DEVICE_ATTR(request, S_IRUGO | S_IWUSR | S_IWGRP,
 static DEVICE_ATTR(transition_action, S_IRUGO,
 		   tpm_show_ppi_transition_action, NULL);
 static DEVICE_ATTR(response, S_IRUGO, tpm_show_ppi_response, NULL);
-static DEVICE_ATTR(tcg_operations, S_IRUGO, tpm_show_ppi_tcg_operations, NULL);
-static DEVICE_ATTR(vs_operations, S_IRUGO, tpm_show_ppi_vs_operations, NULL);
+static DEVICE_ATTR(tcg_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_tcg_operations, NULL);
+static DEVICE_ATTR(vs_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_vs_operations, NULL);
 
 static struct attribute *ppi_attrs[] = {
 	&dev_attr_version.attr,
-- 
2.48.1


