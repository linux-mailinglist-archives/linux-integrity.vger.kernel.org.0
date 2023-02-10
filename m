Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7340B6919B5
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 09:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBJIF6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 03:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjBJIFN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 03:05:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122B8074F;
        Fri, 10 Feb 2023 00:04:37 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7wZLm013901;
        Fri, 10 Feb 2023 08:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ufq03sxlKcM4fJM7m9OQUwYu9n4sTonoeB8rVuBDA/s=;
 b=klKgPnm9GpXFzIQrbJ6owuCLrUO9uIkAFGdSbgYNhDIbOfWjXi7UYnoeJ0kqv0pKekRt
 L8dp7hVmudY0IijVq0sowxo1Qui7O5WBYk1FDUcFo+pCwK95HvdXOd8Jrvd1QBEibp+z
 M7RWof7ONjdVSsKBzzoVaQbpb2qAmscNovEviLi+3XjkDRGvmaGeMScSK2VACvXAYxzs
 v4LqV1uDjB4dCft7Kfuq0W7BUdCjyFPtqj7tr50Ka5gA+hG3HbEkLPJvZtXFGzRlQC6g
 bf51yFD/faLY8go8AqlGM8i8+dbcEjI732hzKiQPK4QdnaZDWDNwT+yKK0VCQcIXJeul zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnj0sr5gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A7wrOZ014490;
        Fri, 10 Feb 2023 08:04:29 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnj0sr5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:29 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319D65dx005776;
        Fri, 10 Feb 2023 08:04:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nhf06n40h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84NJB23397108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAFFC20043;
        Fri, 10 Feb 2023 08:04:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1AC420040;
        Fri, 10 Feb 2023 08:04:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:22 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 85A2A609A2;
        Fri, 10 Feb 2023 19:04:15 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 17/26] powerpc/pseries: Implement signed update for PLPKS objects
Date:   Fri, 10 Feb 2023 19:03:52 +1100
Message-Id: <20230210080401.345462-18-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210080401.345462-1-ajd@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yddcBJeUW4ZxZwRLbcjZ5s-tP9lTadIU
X-Proofpoint-GUID: ienj2NToylmtsmS-89KlEUd0TynZGOhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

The Platform Keystore provides a signed update interface which can be used
to create, replace or append to certain variables in the PKS in a secure
fashion, with the hypervisor requiring that the update be signed using the
Platform Key.

Implement an interface to the H_PKS_SIGNED_UPDATE hcall in the plpks
driver to allow signed updates to PKS objects.

(The plpks driver doesn't need to do any cryptography or otherwise handle
the actual signed variable contents - that will be handled by userspace
tooling.)

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
[ajd: split patch, add timeout handling and misc cleanups]
Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

---

v3: Merge plpks fixes and signed update series with secvar series

    Fix error code handling in plpks_confirm_object_flushed() (ruscur)

    Pass plpks_var struct to plpks_signed_update_var() by reference (mpe)

    Consistent constant naming scheme (ruscur)

v4: Fix MAX_HCALL_OPCODE rebasing issue (npiggin)

v5: Drop the EXPORT_SYMBOL since we don't need it (npiggin)

    Return an error if plpks_signed_update_var() is called with non-NULL
    component (npiggin)
---
 arch/powerpc/include/asm/hvcall.h      |  1 +
 arch/powerpc/include/asm/plpks.h       |  5 ++
 arch/powerpc/platforms/pseries/plpks.c | 74 ++++++++++++++++++++++++--
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 95fd7f9485d5..c099780385dd 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -335,6 +335,7 @@
 #define H_RPT_INVALIDATE	0x448
 #define H_SCM_FLUSH		0x44C
 #define H_GET_ENERGY_SCALE_INFO	0x450
+#define H_PKS_SIGNED_UPDATE	0x454
 #define H_WATCHDOG		0x45C
 #define MAX_HCALL_OPCODE	H_WATCHDOG
 
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 7c5f51a9af7c..e7204e6c0ca4 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -68,6 +68,11 @@ struct plpks_var_name_list {
 	struct plpks_var_name varlist[];
 };
 
+/**
+ * Updates the authenticated variable. It expects NULL as the component.
+ */
+int plpks_signed_update_var(struct plpks_var *var, u64 flags);
+
 /**
  * Writes the specified var and its data to PKS.
  * Any caller of PKS driver should present a valid component type for
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 1189246b03dc..cee06fb9a370 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -81,6 +81,12 @@ static int pseries_status_to_err(int rc)
 		err = -ENOENT;
 		break;
 	case H_BUSY:
+	case H_LONG_BUSY_ORDER_1_MSEC:
+	case H_LONG_BUSY_ORDER_10_MSEC:
+	case H_LONG_BUSY_ORDER_100_MSEC:
+	case H_LONG_BUSY_ORDER_1_SEC:
+	case H_LONG_BUSY_ORDER_10_SEC:
+	case H_LONG_BUSY_ORDER_100_SEC:
 		err = -EBUSY;
 		break;
 	case H_AUTHORITY:
@@ -184,14 +190,17 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 				     u16 namelen)
 {
 	struct label *label;
-	size_t slen;
+	size_t slen = 0;
 
 	if (!name || namelen > PLPKS_MAX_NAME_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	slen = strlen(component);
-	if (component && slen > sizeof(label->attr.prefix))
-		return ERR_PTR(-EINVAL);
+	// Support NULL component for signed updates
+	if (component) {
+		slen = strlen(component);
+		if (slen > sizeof(label->attr.prefix))
+			return ERR_PTR(-EINVAL);
+	}
 
 	// The label structure must not cross a page boundary, so we align to the next power of 2
 	label = kzalloc(roundup_pow_of_two(sizeof(*label)), GFP_KERNEL);
@@ -397,6 +406,61 @@ static int plpks_confirm_object_flushed(struct label *label,
 	return pseries_status_to_err(rc);
 }
 
+int plpks_signed_update_var(struct plpks_var *var, u64 flags)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	int rc;
+	struct label *label;
+	struct plpks_auth *auth;
+	u64 continuetoken = 0;
+	u64 timeout = 0;
+
+	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
+		return -EINVAL;
+
+	if (!(var->policy & PLPKS_SIGNEDUPDATE))
+		return -EINVAL;
+
+	// Signed updates need the component to be NULL.
+	if (var->component)
+		return -EINVAL;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(var->component, var->os, var->name, var->namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	do {
+		rc = plpar_hcall9(H_PKS_SIGNED_UPDATE, retbuf,
+				  virt_to_phys(auth), virt_to_phys(label),
+				  label->size, var->policy, flags,
+				  virt_to_phys(var->data), var->datalen,
+				  continuetoken);
+
+		continuetoken = retbuf[0];
+		if (pseries_status_to_err(rc) == -EBUSY) {
+			int delay_ms = get_longbusy_msecs(rc);
+			mdelay(delay_ms);
+			timeout += delay_ms;
+		}
+		rc = pseries_status_to_err(rc);
+	} while (rc == -EBUSY && timeout < PLPKS_MAX_TIMEOUT);
+
+	if (!rc)
+		rc = plpks_confirm_object_flushed(label, auth);
+
+	kfree(label);
+out:
+	kfree(auth);
+
+	return rc;
+}
+
 int plpks_write_var(struct plpks_var var)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
@@ -443,7 +507,7 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 	struct label *label;
 	int rc;
 
-	if (!component || vname.namelen > PLPKS_MAX_NAME_SIZE)
+	if (vname.namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
 	auth = construct_auth(PLPKS_OS_OWNER);
-- 
2.39.1

