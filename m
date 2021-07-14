Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFA3C9201
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhGNU0l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 16:26:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44552 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhGNU0l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 16:26:41 -0400
Received: from [10.106.164.77] (unknown [131.107.8.205])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5D41920B6C14;
        Wed, 14 Jul 2021 13:23:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D41920B6C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626294229;
        bh=zlb38740nFnr+FeQuol+OnECWN2DulJmyroAg3l0Lgk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=CYlz/jC1eF6ZTM+GoxVsBzOPH+xZ703LgXBPv+NwRnOdfI0cfLnIaQ0WebC24pJRy
         hw9QYRhOzYZ11iNzWTZs2K9+Qohc00ogL2Ic/Odfeayj1UTYg6bkO5ele98gf+gKPh
         UiDFE5AMttecHYTQwydUZUunGTOD7KMNfWEbWkyA=
Subject: Re: [PATCH 6/7] dm: update target specific status functions to
 measure data
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
 <20210713004904.8808-7-tusharsu@linux.microsoft.com>
 <20210713010604.GA6990@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <004ec8ab-1037-481d-35c0-3c06ae70a619@linux.microsoft.com>
Date:   Wed, 14 Jul 2021 13:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713010604.GA6990@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/12/21 6:06 PM, Alasdair G Kergon wrote:
> On Mon, Jul 12, 2021 at 05:49:03PM -0700, Tushar Sugandhi wrote:
>> The DM target data measured by IMA subsystem can alternatively
>> be queried from userspace by setting DM_IMA_MEASUREMENT_FLAG with
>> DM_TABLE_STATUS_CMD.
> I was able to try this out - as 'dmsetup measure' - by applying the quick
> patch below to the upstream LVM2 tree.
>   
> Alasdair

Thanks Alasdair for trying this out, and sharing the dmsetup sample code.

Regards,
Tushar
>
> diff --git a/libdm/.exported_symbols.DM_1_02_179 b/libdm/.exported_symbols.DM_1_02_179
> new file mode 100644
> index 000000000..4ab603b68
> --- /dev/null
> +++ b/libdm/.exported_symbols.DM_1_02_179
> @@ -0,0 +1 @@
> +dm_task_ima_measurement
> diff --git a/libdm/dm-tools/dmsetup.c b/libdm/dm-tools/dmsetup.c
> index a3d1248bc..3e5983fef 100644
> --- a/libdm/dm-tools/dmsetup.c
> +++ b/libdm/dm-tools/dmsetup.c
> @@ -2446,6 +2446,9 @@ static int _status(CMD_ARGS)
>   	if (_switches[NOFLUSH_ARG] && !dm_task_no_flush(dmt))
>   		goto_out;
>   
> +	if (!dm_task_ima_measurement(dmt))
> +		goto_out;
> +
>   	if (!_task_run(dmt))
>   		goto_out;
>   
> @@ -6262,6 +6265,7 @@ static struct command _dmsetup_commands[] = {
>   	{"stats", "<command> [<options>] [<device>...]", 1, -1, 1, 1, _stats},
>   	{"status", "[<device>...] [--noflush] [--target <target_type>]", 0, -1, 2, 0, _status},
>   	{"table", "[<device>...] [--concise] [--target <target_type>] [--showkeys]", 0, -1, 2, 0, _status},
> +	{"measure", "[<device>...]", 0, -1, 2, 0, _status},
>   	{"wait", "<device> [<event_nr>] [--noflush]", 0, 2, 0, 0, _wait},
>   	{"mknodes", "[<device>...]", 0, -1, 1, 0, _mknodes},
>   	{"mangle", "[<device>...]", 0, -1, 1, 0, _mangle},
> diff --git a/libdm/ioctl/libdm-iface.c b/libdm/ioctl/libdm-iface.c
> index 47f14398c..22cce8e76 100644
> --- a/libdm/ioctl/libdm-iface.c
> +++ b/libdm/ioctl/libdm-iface.c
> @@ -929,6 +929,13 @@ int dm_task_secure_data(struct dm_task *dmt)
>   	return 1;
>   }
>   
> +int dm_task_ima_measurement(struct dm_task *dmt)
> +{
> +	dmt->ima_measurement = 1;
> +
> +	return 1;
> +}
> +
>   int dm_task_retry_remove(struct dm_task *dmt)
>   {
>   	dmt->retry_remove = 1;
> @@ -1286,7 +1293,14 @@ static struct dm_ioctl *_flatten(struct dm_task *dmt, unsigned repeat_count)
>   		}
>   		dmi->flags |= DM_UUID_FLAG;
>   	}
> -
> +	if (dmt->ima_measurement) {
> +		if (_dm_version_minor < 45) {
> +			log_error("WARNING: IMA measurement unsupported by "
> +				  "kernel.  Aborting operation.");
> +			goto bad;
> +		}
> +		dmi->flags |= DM_IMA_MEASUREMENT_FLAG;
> +	}
>   	dmi->target_count = count;
>   	dmi->event_nr = dmt->event_nr;
>   
> @@ -1487,6 +1501,7 @@ static int _create_and_load_v4(struct dm_task *dmt)
>   	task->head = dmt->head;
>   	task->tail = dmt->tail;
>   	task->secure_data = dmt->secure_data;
> +	task->ima_measurement = dmt->ima_measurement;
>   
>   	r = dm_task_run(task);
>   
> @@ -1875,7 +1890,7 @@ static struct dm_ioctl *_do_dm_ioctl(struct dm_task *dmt, unsigned command,
>   	}
>   
>   	log_debug_activation("dm %s %s%s %s%s%s %s%.0d%s%.0d%s"
> -			     "%s[ %s%s%s%s%s%s%s%s%s] %.0" PRIu64 " %s [%u] (*%u)",
> +			     "%s[ %s%s%s%s%s%s%s%s%s%s] %.0" PRIu64 " %s [%u] (*%u)",
>   			     _cmd_data_v4[dmt->type].name,
>   			     dmt->new_uuid ? "UUID " : "",
>   			     dmi->name, dmi->uuid, dmt->newname ? " " : "",
> @@ -1893,6 +1908,7 @@ static struct dm_ioctl *_do_dm_ioctl(struct dm_task *dmt, unsigned command,
>   			     dmt->retry_remove ? "retryremove " : "",
>   			     dmt->deferred_remove ? "deferredremove " : "",
>   			     dmt->secure_data ? "securedata " : "",
> +			     dmt->ima_measurement ? "ima_measurement " : "",
>   			     dmt->query_inactive_table ? "inactive " : "",
>   			     dmt->enable_checks ? "enablechecks " : "",
>   			     dmt->sector, _sanitise_message(dmt->message),
> diff --git a/libdm/ioctl/libdm-targets.h b/libdm/ioctl/libdm-targets.h
> index 294210d2b..022b02c72 100644
> --- a/libdm/ioctl/libdm-targets.h
> +++ b/libdm/ioctl/libdm-targets.h
> @@ -69,6 +69,7 @@ struct dm_task {
>   	int enable_checks;
>   	int expected_errno;
>   	int ioctl_errno;
> +	int ima_measurement;
>   
>   	int record_timestamp;
>   
> diff --git a/libdm/libdevmapper.h b/libdm/libdevmapper.h
> index ac31b59da..e9412da7d 100644
> --- a/libdm/libdevmapper.h
> +++ b/libdm/libdevmapper.h
> @@ -235,6 +235,7 @@ int dm_task_suppress_identical_reload(struct dm_task *dmt);
>   int dm_task_secure_data(struct dm_task *dmt);
>   int dm_task_retry_remove(struct dm_task *dmt);
>   int dm_task_deferred_remove(struct dm_task *dmt);
> +int dm_task_ima_measurement(struct dm_task *dmt);
>   
>   /*
>    * Record timestamp immediately after the ioctl returns.
> diff --git a/libdm/libdm-common.c b/libdm/libdm-common.c
> index 708414676..d123e3ddf 100644
> --- a/libdm/libdm-common.c
> +++ b/libdm/libdm-common.c
> @@ -336,6 +336,7 @@ struct dm_task *dm_task_create(int type)
>   	dmt->new_uuid = 0;
>   	dmt->secure_data = 0;
>   	dmt->record_timestamp = 0;
> +	dmt->ima_measurement = 0;
>   
>   	return dmt;
>   }
> diff --git a/libdm/misc/dm-ioctl.h b/libdm/misc/dm-ioctl.h
> index 55dee2148..2b442ab70 100644
> --- a/libdm/misc/dm-ioctl.h
> +++ b/libdm/misc/dm-ioctl.h
> @@ -1,6 +1,7 @@
> +/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
>   /*
>    * Copyright (C) 2001 - 2003 Sistina Software (UK) Limited.
> - * Copyright (C) 2004 - 2017 Red Hat, Inc. All rights reserved.
> + * Copyright (C) 2004 - 2021 Red Hat, Inc. All rights reserved.
>    *
>    * This file is released under the LGPL.
>    */
> @@ -183,7 +184,7 @@ struct dm_target_spec {
>   struct dm_target_deps {
>   	uint32_t count;	/* Array size */
>   	uint32_t padding;	/* unused */
> -	uint64_t dev[];		/* out */
> +	uint64_t dev[0];	/* out */
>   };
>   
>   /*
> @@ -193,9 +194,23 @@ struct dm_name_list {
>   	uint64_t dev;
>   	uint32_t next;		/* offset to the next record from
>   				   the _start_ of this */
> -	char name[];
> +	char name[0];
> +
> +	/*
> +	 * The following members can be accessed by taking a pointer that
> +	 * points immediately after the terminating zero character in "name"
> +	 * and aligning this pointer to next 8-byte boundary.
> +	 * Uuid is present if the flag DM_NAME_LIST_FLAG_HAS_UUID is set.
> +	 *
> +	 * uint32_t event_nr;
> +	 * uint32_t flags;
> +	 * char uuid[0];
> +	 */
>   };
>   
> +#define DM_NAME_LIST_FLAG_HAS_UUID		1
> +#define DM_NAME_LIST_FLAG_DOESNT_HAVE_UUID	2
> +
>   /*
>    * Used to retrieve the target versions
>    */
> @@ -203,7 +218,7 @@ struct dm_target_versions {
>           uint32_t next;
>           uint32_t version[3];
>   
> -        char name[];
> +        char name[0];
>   };
>   
>   /*
> @@ -212,7 +227,7 @@ struct dm_target_versions {
>   struct dm_target_msg {
>   	uint64_t sector;	/* Device sector */
>   
> -	char message[];
> +	char message[0];
>   };
>   
>   /*
> @@ -267,15 +282,15 @@ enum {
>   #define DM_TABLE_STATUS  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, struct dm_ioctl)
>   
>   #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
> +#define DM_GET_TARGET_VERSION _IOWR(DM_IOCTL, DM_GET_TARGET_VERSION_CMD, struct dm_ioctl)
>   
>   #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
>   #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
> -#define DM_GET_TARGET_VERSION	_IOWR(DM_IOCTL, DM_GET_TARGET_VERSION_CMD, struct dm_ioctl)
>   
>   #define DM_VERSION_MAJOR	4
> -#define DM_VERSION_MINOR	36
> +#define DM_VERSION_MINOR	45
>   #define DM_VERSION_PATCHLEVEL	0
> -#define DM_VERSION_EXTRA	"-ioctl (2017-06-09)"
> +#define DM_VERSION_EXTRA	"-ioctl (2021-03-22)"
>   
>   /* Status bits */
>   #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
> @@ -363,4 +378,10 @@ enum {
>    */
>   #define DM_INTERNAL_SUSPEND_FLAG	(1 << 18) /* Out */
>   
> +/*
> + * If set, returns in the in buffer passed by UM, the raw table information
> + * that would be measured by IMA subsystem on device state change.
> + */
> +#define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
> +
>   #endif				/* _LINUX_DM_IOCTL_H */
