Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CDA1FEBFE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgFRHLM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:11:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60676 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFRHLL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:11:11 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2CB7A20B4783;
        Thu, 18 Jun 2020 00:11:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CB7A20B4783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592464270;
        bh=A0GiQILHZ8uuNOX7+rBVoRsb1esS85HaWBTuDqTUAM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixHKZ/xQIYNcJIA9BE4KrIbjwT0LdW+G2r+zYBqwNbWNH109H6oJwoZ55KK/1rHMF
         zDbf30HMELw5TZ3FWiLSdBVIQVNopsycaccVcaHl3PXGOOTza1ZjU7noxo4fAsdRFh
         sPyrgvlID5Gdj2Adjaje8Sum1mYYaHoWYTjZWerE=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [V2 PATCH 2/3] dt-bindings: chosen: Document ima-kexec-buffer 
Date:   Thu, 18 Jun 2020 00:10:44 -0700
Message-Id: <20200618071045.471131-3-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618071045.471131-1-prsriva@linux.microsoft.com>
References: <20200618071045.471131-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Integrity measurement architecture(IMA) validates if files
have been accidentally or maliciously altered, both remotely and
locally, appraise a file's measurement against a "good" value stored
as an extended attribute, and enforce local file integrity.

IMA also measures singatures of kernel and initrd during kexec along with
the command line used for kexec.
These measurements are critical to verify the seccurity posture of the OS.

Resering memory and adding the memory information to a device tree node
acts as the mechanism to carry over IMA measurement logs.

Update devicetree documentation to reflect the addition of new property
under the chosen node. 

---
 Documentation/devicetree/bindings/chosen.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..a15f70c007ef 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -135,3 +135,20 @@ e.g.
 		linux,initrd-end = <0x82800000>;
 	};
 };
+
+linux,ima-kexec-buffer
+----------------------
+
+This property(currently used by powerpc, arm64) holds the memory range,
+the address and the size, of the IMA measurement logs that are being carried
+over to the kexec session.
+
+/ {
+	chosen {
+		linux,ima-kexec-buffer = <0x9 0x82000000 0x0 0x00008000>;
+	};
+};
+
+This porperty does not represent real hardware, but the memory allocated for
+carrying the IMA measurement logs. The address and the suze are expressed in
+#address-cells and #size-cells, respectively of the root node.
-- 
2.25.1

