Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF932029C
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBTBfb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhBTBfK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:35:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF467C0611C1
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u1so8817932ybu.14
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yAS0db83NOvwvM9lfRGQuy1QnGkOfJS/tz8Vl+zvFMk=;
        b=vNMYaLsjV2HvgP0sU96BmGUNkZ6giTH4K10g080lTn/Ugb7UbVG1ZlvV4WQUuihihT
         m/Of1WZXYlY3a9WXvW/e100aspdOcBBqvCWyQknfjbya4DeoWSqRZ4LLM2Dkn6EmyC9M
         NaisJ7C7DWPUWaz2i36fHHI7GDLnMmuX5U1qZUQWPwxfAKKJvt0mrhhWNV5bu5x99ECh
         NlVzJIRL/7TgBsTBiPS5iSXAx/IpWGiFyQ2lpnAHVJQuwdLLLFUBDS71XaRG5bAwTiQk
         q7n6YgdBj2RTdLkeGuagVsRkvL+GT9ojM6M8/2RIpGYRLIVlxL6fSJBzwex/anhYPN5y
         iJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yAS0db83NOvwvM9lfRGQuy1QnGkOfJS/tz8Vl+zvFMk=;
        b=XJYc2uM4K/SGlp/Z7esky7V9+Zsvo3rz19qaTSNLNQoRiDufvZLKzULeI6BQqC3UcI
         dBkUVEPTAmsqj51kfUli44OSKcHLbYk/HLaZ3hhGbM7qHQSqvWLNmsp6o28zI66ON94M
         3mjErDzpoys3gihcXFQ2xY0mcP3kqavSuJ9hwuApdTf7slxdQD9rSPFwoDbOrycUYqnX
         Z9BWgenQ99lc4Zyb8qDVZZWmkbENxCgDi0x+biTnvjE29pCTDsLM21imGRFzxz49VfDS
         bnqCDfNVuBmlk/BxVKUpvpi5QafLg0ddCJb9BIJQcFT4G5oEg6DKod+TO9kpR7Vn438V
         GDFw==
X-Gm-Message-State: AOAM533XXbCm3ZtX5ZaM8TgIGLJTc2DARN6dqmCd9mJOSkwJxktsz6w/
        n9gegQbxVm5VFErNjNn7X1W1peT+B8eqoLdETzoyuA==
X-Google-Smtp-Source: ABdhPJylvuxVey2oMDy3Y+4tyu3KCIe8082QL0jCnfFGtWVDdwBQo9cOVp5MYVFW43mTvmmgfPXtg9tpiDL2UBytgJbjpA==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a25:dad2:: with SMTP id
 n201mr16502549ybf.470.1613784796094; Fri, 19 Feb 2021 17:33:16 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:52 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 6/9] pm: hibernate: Optionally store and verify a hash of the image
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calculate and store a cryptographically secure hash of the hibernation
image if SF_VERIFY_IMAGE is set in the hibernation flags. This allows
detection of a corrupt image, but has the disadvantage that it requires
the blocks be read in in linear order.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 kernel/power/power.h |   1 +
 kernel/power/swap.c  | 131 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 110 insertions(+), 22 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 778bf431ec02..b8e00b9dcee8 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -168,6 +168,7 @@ extern int swsusp_swap_in_use(void);
 #define SF_PLATFORM_MODE	1
 #define SF_NOCOMPRESS_MODE	2
 #define SF_CRC32_MODE	        4
+#define SF_VERIFY_IMAGE         8
 
 /* kernel/power/hibernate.c */
 extern int swsusp_check(void);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 72e33054a2e1..a13241a20567 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -31,6 +31,8 @@
 #include <linux/kthread.h>
 #include <linux/crc32.h>
 #include <linux/ktime.h>
+#include <crypto/hash.h>
+#include <crypto/sha2.h>
 
 #include "power.h"
 
@@ -95,17 +97,20 @@ struct swap_map_page_list {
 struct swap_map_handle {
 	struct swap_map_page *cur;
 	struct swap_map_page_list *maps;
+	struct shash_desc *desc;
 	sector_t cur_swap;
 	sector_t first_sector;
 	unsigned int k;
 	unsigned long reqd_free_pages;
 	u32 crc32;
+	u8 digest[SHA256_DIGEST_SIZE];
 };
 
 struct swsusp_header {
 	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
-	              sizeof(u32)];
+		      sizeof(u32) - SHA256_DIGEST_SIZE];
 	u32	crc32;
+	u8	digest[SHA256_DIGEST_SIZE];
 	sector_t image;
 	unsigned int flags;	/* Flags to pass to the "boot" kernel */
 	char	orig_sig[10];
@@ -305,6 +310,9 @@ static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
 	 * We are relying on the behavior of blk_plug that a thread with
 	 * a plug will flush the plug list before sleeping.
 	 */
+	if (!hb)
+		return 0;
+
 	wait_event(hb->wait, atomic_read(&hb->count) == 0);
 	return blk_status_to_errno(hb->error);
 }
@@ -327,6 +335,8 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
+		memcpy(swsusp_header->digest, handle->digest,
+		       SHA256_DIGEST_SIZE);
 		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
 				      swsusp_resume_block, swsusp_header, NULL);
 	} else {
@@ -417,6 +427,7 @@ static void release_swap_writer(struct swap_map_handle *handle)
 static int get_swap_writer(struct swap_map_handle *handle)
 {
 	int ret;
+	struct crypto_shash *tfm;
 
 	ret = swsusp_swap_check();
 	if (ret) {
@@ -437,7 +448,28 @@ static int get_swap_writer(struct swap_map_handle *handle)
 	handle->k = 0;
 	handle->reqd_free_pages = reqd_free_pages();
 	handle->first_sector = handle->cur_swap;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = -EINVAL;
+		goto err_rel;
+	}
+	handle->desc = kmalloc(sizeof(struct shash_desc) +
+			       crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!handle->desc) {
+		ret = -ENOMEM;
+		goto err_rel;
+	}
+
+	handle->desc->tfm = tfm;
+
+	ret = crypto_shash_init(handle->desc);
+	if (ret != 0)
+		goto err_free;
+
 	return 0;
+err_free:
+	kfree(handle->desc);
 err_rel:
 	release_swap_writer(handle);
 err_close:
@@ -446,7 +478,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 }
 
 static int swap_write_page(struct swap_map_handle *handle, void *buf,
-		struct hib_bio_batch *hb)
+			   struct hib_bio_batch *hb, bool hash)
 {
 	int error = 0;
 	sector_t offset;
@@ -454,6 +486,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 	if (!handle->cur)
 		return -EINVAL;
 	offset = alloc_swapdev_block(root_swap);
+	crypto_shash_update(handle->desc, buf, PAGE_SIZE);
 	error = write_page(buf, offset, hb);
 	if (error)
 		return error;
@@ -496,6 +529,7 @@ static int flush_swap_writer(struct swap_map_handle *handle)
 static int swap_writer_finish(struct swap_map_handle *handle,
 		unsigned int flags, int error)
 {
+	crypto_shash_final(handle->desc, handle->digest);
 	if (!error) {
 		pr_info("S");
 		error = mark_swapfiles(handle, flags);
@@ -560,7 +594,7 @@ static int save_image(struct swap_map_handle *handle,
 		ret = snapshot_read_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = swap_write_page(handle, data_of(*snapshot), &hb);
+		ret = swap_write_page(handle, data_of(*snapshot), &hb, true);
 		if (ret)
 			break;
 		if (!(nr_pages % m))
@@ -844,7 +878,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			     off += PAGE_SIZE) {
 				memcpy(page, data[thr].cmp + off, PAGE_SIZE);
 
-				ret = swap_write_page(handle, page, &hb);
+				ret = swap_write_page(handle, page, &hb, true);
 				if (ret)
 					goto out_finish;
 			}
@@ -938,7 +972,7 @@ int swsusp_write(unsigned int flags)
 		goto out_finish;
 	}
 	header = (struct swsusp_info *)data_of(snapshot);
-	error = swap_write_page(&handle, header, NULL);
+	error = swap_write_page(&handle, header, NULL, false);
 	if (!error) {
 		error = (flags & SF_NOCOMPRESS_MODE) ?
 			save_image(&handle, &snapshot, pages - 1) :
@@ -974,6 +1008,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
 	int error;
 	struct swap_map_page_list *tmp, *last;
 	sector_t offset;
+	struct crypto_shash *tfm;
 
 	*flags_p = swsusp_header->flags;
 
@@ -1011,11 +1046,34 @@ static int get_swap_reader(struct swap_map_handle *handle,
 	}
 	handle->k = 0;
 	handle->cur = handle->maps->map;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		error = -EINVAL;
+		goto err_rel;
+	}
+	handle->desc = kmalloc(sizeof(struct shash_desc) +
+			       crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!handle->desc) {
+		error = -ENOMEM;
+		goto err_rel;
+	}
+
+	handle->desc->tfm = tfm;
+
+	error = crypto_shash_init(handle->desc);
+	if (error != 0)
+		goto err_free;
 	return 0;
+err_free:
+	kfree(handle->desc);
+err_rel:
+	release_swap_reader(handle);
+	return error;
 }
 
 static int swap_read_page(struct swap_map_handle *handle, void *buf,
-		struct hib_bio_batch *hb)
+			  struct hib_bio_batch *hb, bool hash)
 {
 	sector_t offset;
 	int error;
@@ -1029,6 +1087,7 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
 	error = hib_submit_io(REQ_OP_READ, 0, offset, buf, hb);
 	if (error)
 		return error;
+	crypto_shash_update(handle->desc, buf, PAGE_SIZE);
 	if (++handle->k >= MAP_PAGE_ENTRIES) {
 		handle->k = 0;
 		free_page((unsigned long)handle->maps->map);
@@ -1043,11 +1102,21 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
 	return error;
 }
 
-static int swap_reader_finish(struct swap_map_handle *handle)
+static int swap_reader_finish(struct swap_map_handle *handle,
+			      struct swsusp_info *header)
 {
+	int ret = 0;
+
+	crypto_shash_final(handle->desc, handle->digest);
+	if (memcmp(handle->digest, swsusp_header->digest,
+		   SHA256_DIGEST_SIZE) != 0) {
+		pr_err("Image digest doesn't match header digest\n");
+		ret = -ENODATA;
+	}
+
 	release_swap_reader(handle);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1064,11 +1133,20 @@ static int load_image(struct swap_map_handle *handle,
 	int ret = 0;
 	ktime_t start;
 	ktime_t stop;
-	struct hib_bio_batch hb;
+	struct hib_bio_batch *hb, real_hb;
 	int err2;
 	unsigned nr_pages;
 
-	hib_init_batch(&hb);
+	/*
+	 * If we're calculating the SHA256 of the image, we need the blocks
+	 * to be read in in order
+	 */
+	if (swsusp_header->flags & SF_VERIFY_IMAGE) {
+		hb = NULL;
+	} else {
+		hib_init_batch(&real_hb);
+		hb = &real_hb;
+	}
 
 	clean_pages_on_read = true;
 	pr_info("Loading image data pages (%u pages)...\n", nr_to_read);
@@ -1081,11 +1159,11 @@ static int load_image(struct swap_map_handle *handle,
 		ret = snapshot_write_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = swap_read_page(handle, data_of(*snapshot), &hb);
+		ret = swap_read_page(handle, data_of(*snapshot), hb, true);
 		if (ret)
 			break;
 		if (snapshot->sync_read)
-			ret = hib_wait_io(&hb);
+			ret = hib_wait_io(hb);
 		if (ret)
 			break;
 		if (!(nr_pages % m))
@@ -1093,8 +1171,8 @@ static int load_image(struct swap_map_handle *handle,
 				nr_pages / m * 10);
 		nr_pages++;
 	}
-	err2 = hib_wait_io(&hb);
-	hib_finish_batch(&hb);
+	err2 = hib_wait_io(hb);
+	hib_finish_batch(hb);
 	stop = ktime_get();
 	if (!ret)
 		ret = err2;
@@ -1169,7 +1247,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	unsigned int m;
 	int ret = 0;
 	int eof = 0;
-	struct hib_bio_batch hb;
+	struct hib_bio_batch *hb, real_hb;
 	ktime_t start;
 	ktime_t stop;
 	unsigned nr_pages;
@@ -1182,7 +1260,16 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	struct dec_data *data = NULL;
 	struct crc_data *crc = NULL;
 
-	hib_init_batch(&hb);
+	/*
+	 * If we're calculating the SHA256 of the image, we need the blocks
+	 * to be read in in order
+	 */
+	if (swsusp_header->flags & SF_VERIFY_IMAGE) {
+		hb = NULL;
+	} else {
+		hib_init_batch(&real_hb);
+		hb = &real_hb;
+	}
 
 	/*
 	 * We'll limit the number of threads for decompression to limit memory
@@ -1301,7 +1388,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 	for(;;) {
 		for (i = 0; !eof && i < want; i++) {
-			ret = swap_read_page(handle, page[ring], &hb);
+			ret = swap_read_page(handle, page[ring], hb, true);
 			if (ret) {
 				/*
 				 * On real read error, finish. On end of data,
@@ -1328,7 +1415,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 			if (!asked)
 				break;
 
-			ret = hib_wait_io(&hb);
+			ret = hib_wait_io(hb);
 			if (ret)
 				goto out_finish;
 			have += asked;
@@ -1382,7 +1469,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		 * Wait for more data while we are decompressing.
 		 */
 		if (have < LZO_CMP_PAGES && asked) {
-			ret = hib_wait_io(&hb);
+			ret = hib_wait_io(hb);
 			if (ret)
 				goto out_finish;
 			have += asked;
@@ -1458,7 +1545,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
 out_clean:
-	hib_finish_batch(&hb);
+	hib_finish_batch(hb);
 	for (i = 0; i < ring_size; i++)
 		free_page((unsigned long)page[i]);
 	if (crc) {
@@ -1499,13 +1586,13 @@ int swsusp_read(unsigned int *flags_p)
 	if (error)
 		goto end;
 	if (!error)
-		error = swap_read_page(&handle, header, NULL);
+		error = swap_read_page(&handle, header, NULL, false);
 	if (!error) {
 		error = (*flags_p & SF_NOCOMPRESS_MODE) ?
 			load_image(&handle, &snapshot, header->pages - 1) :
 			load_image_lzo(&handle, &snapshot, header->pages - 1);
 	}
-	swap_reader_finish(&handle);
+	error = swap_reader_finish(&handle, header);
 end:
 	if (!error)
 		pr_debug("Image successfully loaded\n");
-- 
2.30.0.617.g56c4b15f3c-goog

