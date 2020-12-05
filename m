Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953582CF8C2
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 02:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgLEBpP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 20:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgLEBpP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 20:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607132628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lW9KkMzFLYc1ojPEtP3p/Op0vdlWTjdG3yLjC3/7Lv4=;
        b=HXkRCMFfsEXqiqaEklay0OiyaU4qYNYFfpfOvmqb2nXUUn5/Q4pfwYSfpbf35lFvmNMpPa
        eatqJjkourcfO/q+HU0eOLlUy8IvTdaMP7IHz7UEk9h0VFf4/8xkqL4NpsHEwoWpOwZIxw
        q+wK4n5hZ/rfaWJ1HOJA0kW0nAYqMU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-pQvmrQQvNZqgrpUQIkztzA-1; Fri, 04 Dec 2020 20:43:47 -0500
X-MC-Unique: pQvmrQQvNZqgrpUQIkztzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E678518A;
        Sat,  5 Dec 2020 01:43:45 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-114-119.phx2.redhat.com [10.3.114.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E086360918;
        Sat,  5 Dec 2020 01:43:43 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get interrupt count
Date:   Fri,  4 Dec 2020 18:43:38 -0700
Message-Id: <20201205014340.148235-3-jsnitsel@redhat.com>
In-Reply-To: <20201205014340.148235-1-jsnitsel@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Now that kstat_irqs is exported, get rid of count_interrupts in
i915_pmu.c

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org 
Cc: dri-devel@lists.freedesktop.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 69c0fa20eba1..a3e63f03da8c 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -423,22 +423,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
-static u64 count_interrupts(struct drm_i915_private *i915)
-{
-	/* open-coded kstat_irqs() */
-	struct irq_desc *desc = irq_to_desc(i915->drm.pdev->irq);
-	u64 sum = 0;
-	int cpu;
-
-	if (!desc || !desc->kstat_irqs)
-		return 0;
-
-	for_each_possible_cpu(cpu)
-		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
-
-	return sum;
-}
-
 static void i915_pmu_event_destroy(struct perf_event *event)
 {
 	struct drm_i915_private *i915 =
@@ -581,7 +565,7 @@ static u64 __i915_pmu_event_read(struct perf_event *event)
 				   USEC_PER_SEC /* to MHz */);
 			break;
 		case I915_PMU_INTERRUPTS:
-			val = count_interrupts(i915);
+			val = kstat_irqs(i915->drm.pdev->irq);
 			break;
 		case I915_PMU_RC6_RESIDENCY:
 			val = get_rc6(&i915->gt);
-- 
2.27.0

