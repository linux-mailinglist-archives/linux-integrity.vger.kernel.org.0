Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC13EBDF1
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhHMVij (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:38:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44324 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhHMVii (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:38:38 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6C91520C2935;
        Fri, 13 Aug 2021 14:38:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C91520C2935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628890691;
        bh=zZX7LGLs9wItFDOG3lSr2nLkYfwgSeHJJDYb45LouEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIgId31OlLn4AOzIdsI2jC7n7Rf0EqJ8kfc+R4TVAsTswGVqAL6dFsdd9n4SkkjBA
         fZQeokftBJCHrXS4q+CCLamf6+Bu8s6Dr2tqoL9zrKEBMs2s/R2je490K5UBacOv71
         JkGbK6Vizf90JN69bmBXBq0nqxhTkuLslNTDeEBU=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        sfr@canb.auug.org.au, public@thson.de, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com
Subject: [PATCH 5/6] dm ima: update dm target attributes for ima measurements
Date:   Fri, 13 Aug 2021 14:38:00 -0700
Message-Id: <20210813213801.297051-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Certain DM targets ('integrity', 'multipath', 'verity') need to update the
way their attributes are recorded in the ima log, so that the attestation
servers can interpret the data correctly and decide if the devices
meet the attestation requirements.  For instance, the "mode=%c" attribute
in the 'integrity' target is measured twice, the 'verity' target is
missing the attribute "root_hash_sig_key_desc=%s", and the 'multipath'
target needs to index the attributes properly.

Update 'integrity' target to remove the duplicate measurement of
the attribute "mode=%c".  Add "root_hash_sig_key_desc=%s" attribute
for the 'verity' target.  Index various attributes in 'multipath'
target.  Also, add "nr_priority_groups=%u" attribute to 'multipath'
target to record the number of priority groups.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Thore Sommer <public@thson.de>
---
 drivers/md/dm-integrity.c     |  1 -
 drivers/md/dm-mpath.c         | 26 ++++++++++++++++++--------
 drivers/md/dm-verity-target.c |  2 ++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 40f8116c8e44..6e0b2f2f5911 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3328,7 +3328,6 @@ static void dm_integrity_status(struct dm_target *ti, status_type_t type,
 		DMEMIT(",journal_sectors=%u", ic->initial_sectors - SB_SECTORS);
 		DMEMIT(",interleave_sectors=%u", 1U << ic->sb->log2_interleave_sectors);
 		DMEMIT(",buffer_sectors=%u", 1U << ic->log2_buffer_sectors);
-		DMEMIT(",mode=%c", ic->mode);
 		DMEMIT(";");
 		break;
 	}
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index c3c514a9edbb..694aaca4eea2 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1790,7 +1790,7 @@ static void multipath_resume(struct dm_target *ti)
 static void multipath_status(struct dm_target *ti, status_type_t type,
 			     unsigned status_flags, char *result, unsigned maxlen)
 {
-	int sz = 0;
+	int sz = 0, pg_counter, pgpath_counter;
 	unsigned long flags;
 	struct multipath *m = ti->private;
 	struct priority_group *pg;
@@ -1906,7 +1906,12 @@ static void multipath_status(struct dm_target *ti, status_type_t type,
 		break;
 
 	case STATUSTYPE_IMA:
+		sz = 0; /*reset the result pointer*/
+
 		DMEMIT_TARGET_NAME_VERSION(ti->type);
+		DMEMIT(",nr_priority_groups=%u", m->nr_priority_groups);
+
+		pg_counter = 0;
 		list_for_each_entry(pg, &m->priority_groups, list) {
 			if (pg->bypassed)
 				state = 'D';	/* Disabled */
@@ -1914,21 +1919,26 @@ static void multipath_status(struct dm_target *ti, status_type_t type,
 				state = 'A';	/* Currently Active */
 			else
 				state = 'E';	/* Enabled */
-			DMEMIT(",pg_state=%c", state);
-			DMEMIT(",nr_pgpaths=%u", pg->nr_pgpaths);
-			DMEMIT(",path_selector_name=%s", pg->ps.type->name);
+			DMEMIT(",pg_state_%d=%c", pg_counter, state);
+			DMEMIT(",nr_pgpaths_%d=%u", pg_counter, pg->nr_pgpaths);
+			DMEMIT(",path_selector_name_%d=%s", pg_counter, pg->ps.type->name);
 
+			pgpath_counter = 0;
 			list_for_each_entry(p, &pg->pgpaths, list) {
-				DMEMIT(",path_name=%s,is_active=%c,fail_count=%u",
-				       p->path.dev->name, p->is_active ? 'A' : 'F',
-				       p->fail_count);
+				DMEMIT(",path_name_%d_%d=%s,is_active_%d_%d=%c,fail_count_%d_%d=%u",
+				       pg_counter, pgpath_counter, p->path.dev->name,
+				       pg_counter, pgpath_counter, p->is_active ? 'A' : 'F',
+				       pg_counter, pgpath_counter, p->fail_count);
 				if (pg->ps.type->status) {
-					DMEMIT(",path_selector_status=");
+					DMEMIT(",path_selector_status_%d_%d=",
+					       pg_counter, pgpath_counter);
 					sz += pg->ps.type->status(&pg->ps, &p->path,
 								  type, result + sz,
 								  maxlen - sz);
 				}
+				pgpath_counter++;
 			}
+			pg_counter++;
 		}
 		DMEMIT(";");
 		break;
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index bfefa100c265..22a5ac82446a 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -794,6 +794,8 @@ static void verity_status(struct dm_target *ti, status_type_t type,
 
 		DMEMIT(",ignore_zero_blocks=%c", v->zero_digest ? 'y' : 'n');
 		DMEMIT(",check_at_most_once=%c", v->validated_blocks ? 'y' : 'n');
+		if (v->signature_key_desc)
+			DMEMIT(",root_hash_sig_key_desc=%s", v->signature_key_desc);
 
 		if (v->mode != DM_VERITY_MODE_EIO) {
 			DMEMIT(",verity_mode=");
-- 
2.32.0

